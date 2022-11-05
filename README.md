# nginxWebUI-Docker

## Install

**docker-cli**
```bash
docker run -itd \
  -v /home/nginxWebUI:/home/nginxWebUI \
  -e BOOT_OPTIONS="--server.port=8080" \
  -e PUID=1000 \
  -e PGID=1000 \
  --privileged=true \
  --net=host \
  ddsderek/nginxwebui:latest
```

**docker-compose**
```yaml
version: '3.3'
services:
    nginxwebui:
        volumes:
            - '/home/nginxWebUI:/home/nginxWebUI'
        environment:
            - BOOT_OPTIONS=--server.port=8080
            - PUID=1000
            - PGID=1000
        privileged: true
        network_mode: host
        image: 'ddsderek/nginxwebui:latest'
```
