FROM ubuntu:20.04

RUN apt update && apt install -y wget unzip openjdk-8-jdk-headless
RUN wget https://downloads.jboss.org/apiman/1.5.5.Final/apiman-distro-vertx-1.5.5.Final.zip
RUN unzip -o apiman-distro-vertx-1.5.5.Final.zip && rm apiman-distro-vertx-1.5.5.Final.zip && cd apiman-distro-vertx-1.5.5.Final
EXPOSE 8081

CMD ["/apiman-distro-vertx-1.5.5.Final/apiman-gateway.sh","--conf","/apiman-distro-vertx-1.5.5.Final/configs/conf-es.json"]
