[MariaDB] (https://mariadb.org/mariadb-10-1-1-galera-support/) 10.1 Galera cluster on Ubuntu 14.04
--------------------------------------------------------------------------------------------------

=======
# MariaDB 10.1 Galera cluster on Ubuntu 14.04

MariaDB 10.1 with the buildin Galera software. This Docker sets up a 3 node cluster fully operational perfect for testing. You can adjust the IP's by editing the docker run and the my.cnf. In this sample 172.17.0.10, 172.17.0.11 and 172.17.0.12 is used. Default user is root and the password is blank.

Get the Docker image 
====================

`docker pull howrude/mariadb-10.1-galera`  
or make it yourelf with the Dockerfile
`docker build -t galera .`  

Boot the nodes
==============

### start the first node (galeranode0 - 172.17.0.10) with bootstrap
```bash
docker run --cap-add=NET_ADMIN --add-host galeranode0:172.17.0.10 --add-host galeranode1:172.17.0.11 --add-host galeranode2:172.17.0.12 --name=galeranode0 -h galeranode0 -dit galera /bin/sh -c "/sbin/ip addr add 172.17.0.10 dev eth0; bash"`  
docker exec -ti galeranode0 service mysql bootstrap
```

### start the second node (galeranode1 - 172.17.0.11)
```bash
docker run --cap-add=NET_ADMIN --add-host galeranode0:172.17.0.10 --add-host galeranode1:172.17.0.11 --add-host galeranode2:172.17.0.12 --name=galeranode1 -h galeranode1 -dit galera /bin/sh -c "/sbin/ip addr add 172.17.0.11 dev eth0; bash" 
docker exec -ti galeranode1 service mysql start
```

### start the third node (galeranode2 - 172.17.0.12)
```bash
docker run --cap-add=NET_ADMIN --add-host galeranode0:172.17.0.10 --add-host galeranode1:172.17.0.11 --add-host galeranode2:172.17.0.12 --name=galeranode2 -h galeranode2 -dit galera /bin/sh -c "/sbin/ip addr add 172.17.0.12 dev eth0; bash"  
docker exec -ti galeranode2 service mysql start
```

Check you cluster size
======================

With the command below you can check the cluster size, wich should be 3.
`docker exec -ti galeranode1 mysql -e 'show status like "wsrep_cluster_size"'`

Login into the nodes
====================

You can login into the nodes with bash using the command below.  
`docker exec -ti galeranode2 /bin/bash`  
and run a SQL command using
`mysql -h galeranode0 -u root -p`  
with this you can see that all commands are replicated
