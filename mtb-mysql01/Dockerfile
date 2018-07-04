FROM centos:centos7
MAINTAINER Jordi Prats

RUN yum clean all
RUN yum install mariadb mariadb-server MySQL-python -y

COPY server.cnf /etc/my.cnf.d/
