FROM kong:2.1.2-ubuntu
LABEL maintainer="mestevez@afip.gob.ar"

USER root

RUN apt update \
&& apt install -y \
        libssl-dev \
        gcc \
        git \
        wget \
&& rm -rf /var/lib/apt/lists/*

RUN luarocks install luacrypto
RUN luarocks install kong-path-whitelist
RUN luarocks install lua-resty-kafka
RUN luarocks install kong-kafka-log
RUN luarocks install kong-spec-expose
RUN luarocks install kong-response-size-limiting
RUN luarocks install kong-upstream-jwt
RUN luarocks install kong-plugin-jwt-keycloak

RUN git clone https://github.com/matiaet98/kong-oidc.git \
        && cd kong-oidc \
        && luarocks make

RUN git clone https://github.com/matiaet98/kong-keycloak-acl.git \
	&& cd kong-keycloak-acl \
	&& luarocks make

ENV KONG_PLUGINS=bundled,oidc,kong-keycloak-acl,jwt-keycloak,kong-kafka-log,kong-spec-expose,kong-upstream-jwt,kong-path-whitelist,kong-response-size-limiting
ENV KONG_LOG_LEVEL=info

USER kong

