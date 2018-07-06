FROM centos:centos7
MAINTAINER Jordi Prats

RUN yum clean all
RUN yum install epel-release mariadb mariadb-server MySQL-python -y

RUN yum install supervisor -y

COPY server.cnf /etc/my.cnf.d/
RUN mkdir -p /usr/local/bin

COPY init.sh /usr/local/bin/
COPY startup.sh /usr/local/bin/
COPY appserver.py /usr/local/bin/
COPY appserver.sh /usr/local/bin/
COPY webserver.py /usr/local/bin/

RUN chmod +x /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/appserver.py
RUN chmod +x /usr/local/bin/appserver.sh
RUN chmod +x /usr/local/bin/webserver.py

COPY mysqld.ini /etc/supervisord.d/
COPY appserver.ini /etc/supervisord.d/
COPY webserver.ini /etc/supervisord.d/

RUN mv /usr/bin/systemctl /usr/bin/.systemctl.orig

COPY service.sh /usr/bin/service
RUN chmod +x /usr/bin/service

COPY systemctl.sh /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl

EXPOSE 8080

CMD ["/usr/local/bin/startup.sh"]
