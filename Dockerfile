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

RUN chattr +i /usr/local/bin/init.sh
RUN chattr +i /usr/local/bin/startup.sh
RUN chattr +i /usr/local/bin/appserver.py
RUN chattr +i /usr/local/bin/appserver.sh
RUN chattr +i /usr/local/bin/webserver.py

COPY mysqld.ini /etc/supervisord.d/
COPY appserver.ini /etc/supervisord.d/
COPY webserver.ini /etc/supervisord.d/

RUN chattr +i /etc/supervisord.d/mysqld.ini
RUN chattr +i /etc/supervisord.d/appserver.ini
RUN chattr +i /etc/supervisord.d/webserver.ini

RUN mv /usr/bin/systemctl /usr/bin/.systemctl.orig

COPY service.sh /usr/bin/service
RUN chmod +x /usr/bin/service

COPY systemctl.sh /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl

#
# debug tools
#
RUN yum install net-tools strace -y

#
# audit tools
#
RUN yum install git gcc make patch -y
RUN mkdir -p /usr/local/src
RUN bash -c 'cd /usr/local/src; git clone https://github.com/squash/sudosh2'
COPY sudosh2-docker.patch /usr/local/src/
RUN bash -c 'cd /usr/local/src/sudosh2; patch -p1 < ../sudosh2-docker.patch'
RUN bash -c 'cd /usr/local/src/sudosh2; ./configure'
RUN bash -c 'cd /usr/local/src/sudosh2; make'
RUN bash -c 'cd /usr/local/src/sudosh2; make install'

RUN mkdir -p /var/log/sudosh
RUN chmod 0733 /var/log/sudosh

COPY login.sh /login
RUN chmod +x /login
RUN echo "/login" >> /etc/shells

EXPOSE 8080

CMD ["/usr/local/bin/startup.sh"]
