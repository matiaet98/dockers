FROM jboss/wildfly:18.0.1.Final

LABEL maintainer="Estevez Matias"

RUN cd $HOME/wildfly \
    && curl -L http://downloads.jboss.org/apiman/1.5.5.Final/apiman-distro-wildfly11-1.5.5.Final-overlay.zip -o apiman.zip \
    && unzip -o apiman.zip \
    && rm apiman.zip \
    && rm ./standalone/deployments/apiman-gateway.war \
    && rm ./standalone/deployments/apiman-gateway-api.war \
    && rm ./standalone/deployments/apiman-es.war

USER root

RUN chown -R jboss:0 ${JBOSS_HOME} && chmod -R g+rw ${JBOSS_HOME}

USER jboss

ENTRYPOINT ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone-apiman.xml"]
