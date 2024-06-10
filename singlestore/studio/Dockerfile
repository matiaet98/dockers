FROM centos:latest

# Needing this line is super stupid, centos should fix this asap
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

RUN yum upgrade -y && \
    yum install -y yum-utils

RUN yum-config-manager \
    --add-repo https://release.memsql.com/production/rpm/x86_64/repodata/memsql.repo && \
    yum install -y --nobest memsql-studio

EXPOSE 8080

CMD ["memsql-studio"]