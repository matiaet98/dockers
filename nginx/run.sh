docker run
--network host \
-d \
-v ./default.conf:/etc/nginx/conf.d/default.conf:ro \
--name nginx \
nginx:latest
