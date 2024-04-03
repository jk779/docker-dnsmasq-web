# docker-dnsmasq-web

Add additional hosts to your LAN DNS server with a web interface. This server 
can be entered as a (r)DNS server, preferably in your router or tools like
Pi-hole or AdGuard Home.

- Open in your browser to edit config file: http://localhost:8082
- Use as DNS server: on the same Docker host: IP of the container. 
  - Otherwiese you'd have to expose the port 53/tcp and 53/udp and use Docker 
    hosts IP, or use something like systemd-resolved to forward the DNS requests 
    to the this one.
