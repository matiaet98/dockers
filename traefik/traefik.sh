docker run --detach --publish 8080:8080 --publish 80:80 -v /opt/traefik:/etc/traefik -v /var/run/docker.sock:/var/run/docker.sock --network matinet --name traefik --hostname traefik.matinet traefik:latest


