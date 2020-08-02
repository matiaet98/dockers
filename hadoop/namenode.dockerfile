FROM ubuntu:20.04
LABEL maintainer="matiaet98"
LABEL version="0.1"

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /

RUN apt update && \
    apt install -y openjdk-11-jdk openssh-server openssh-client && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean && \
    useradd -m -G users hdfs

RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz && \
    tar xfz hadoop-3.3.0.tar.gz && \
    rm -fr hadoop-3.3.0.tar.gz && \
    ln -s hadoop-3.3.0 hadoop && \
    mkdir -p /hadoop/log && \
    mkdir -p /hadoop/run && \
    mkdir -p /hadoop/namenode

COPY ./namenode.sh /hadoop
RUN chown -R hdfs:hdfs /hadoop && \
    chown -R hdfs:hdfs /hadoop-3.3.0 && \
    chmod +x /hadoop/namenode.sh

USER hdfs

WORKDIR /hadoop
    
VOLUME ["/hadoop/namenode"]
ENTRYPOINT [ "/hadoop/namenode.sh" ]
