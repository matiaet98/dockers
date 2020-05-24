FROM kong:ubuntu
ENV KONG_PLUGINS=bundled,oidc
ENV KONG_LOG_LEVEL=debug
RUN luarocks install kong-oidc --local

