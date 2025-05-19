FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server
RUN apt-get install -y mariadb-client
RUN apt-get install -y procps

#copy the config files to the container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -m 755 -p /var/run/mysqld
RUN mkdir -m 755 -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld
RUN chown mysql:mysql /var/lib/mysql

EXPOSE 3306

COPY ./tools/dbscript.sh ./
RUN chmod +x ./dbscript.sh

ENTRYPOINT ["bash", "./dbscript.sh"]
