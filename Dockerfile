# # MariaDB 10.1.1: Galera/Ubuntu 14.04 64bit
FROM ubuntu:14.04
MAINTAINER Ruud van der Gijp <rvdgijp@hotmail.com>
 
RUN apt-get install -y software-properties-common
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb [arch=amd64,i386] http://mariadb.mirror.triple-it.nl/repo/10.1/ubuntu trusty main'
RUN apt-get -q -y update
RUN apt-get install -y mariadb-server wget mysql-client
ADD ./my.cnf /etc/mysql/my.cnf
