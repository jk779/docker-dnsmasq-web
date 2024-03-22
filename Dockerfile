FROM alpine:latest

ARG TARGETOS="linux"
ARG TARGETARCH="arm64"
ARG WEBPROC_VERSION="0.4.0"
ARG WEBPROC_URL="https://github.com/jpillora/webproc/releases/download/v${WEBPROC_VERSION}/webproc_${WEBPROC_VERSION}_${TARGETOS}_${TARGETARCH}.gz"

RUN echo $WEBPROC_URL && \
    apk update && \
    apk --no-cache add curl dnsmasq && \
    curl -L $WEBPROC_URL | gunzip -c > /usr/local/bin/webproc && \
    chmod +x /usr/local/bin/webproc

# configure dnsmasq
# /etc/default/dnsmasq doesn't exist, XXX: stale config from Debian?
# RUN echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq
COPY default-dnsmasq.conf /etc/dnsmasq.conf

# The dhcp.leases files is put here, may want to mount as tmpfs
# XXX: should this be preserved?
# VOLUME [ "/var/lib/misc" ]

# Ports:
#  80: Web interface
#  67: DHCP
#  53: DNS: dns on udp, dns transfers on tcp
#EXPOSE 80/tcp 67/udp 53/tcp 53/udp
EXPOSE 80/tcp 53/tcp 53/udp

ENTRYPOINT ["webproc","--port","80","--configuration-file","/etc/dnsmasq.conf","--","dnsmasq","--no-daemon"]

#HEALTHCHECK --interval=30s \
#	--timeout=30s \
#	--start-period=10s \
#	--retries=3 \
#	CMD [ "pidof", "dnsmasq" ]
