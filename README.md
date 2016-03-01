# MariaDB 10.1 Galera cluster on Ubuntu 14.04

MariaDB 10.1 with the build in Galera software. This Docker sets up a 3 node cluster fully operational. Perfect for testing. You can adjust the IP's by editing the docker run and the my.cnf. In this sample 172.17.0.10, 172.17.0.11 and 172.17.0.12 is used.

# Get the Docker image 
`docker pull howrude/mariadb-10.1-galera`  
or make it yourelf with the Dockerfile
`docker build -t galera .`  

# Boot the nodes
### start the first node (galeranode0 - 172.17.0.10) with bootstrap
`docker run --cap-add=NET_ADMIN --add-host galeranode0:172.17.0.10 --add-host galeranode1:172.17.0.11 --add-host galeranode2:172.17.0.12 --name=galeranode0 -h galeranode0 -dit galera /bin/sh -c "/sbin/ip addr add 172.17.0.10 dev eth0; bash"`  
`docker exec -ti galeranode0 service mysql bootstrap`

## start the second node (galeranode1 - 172.17.0.11)
`docker run --cap-add=NET_ADMIN --add-host galeranode0:172.17.0.10 --add-host galeranode1:172.17.0.11 --add-host galeranode2:172.17.0.12 --name=galeranode1 -h galeranode1 -dit galera /bin/sh -c "/sbin/ip addr add 172.17.0.11 dev eth0; bash"`  
`docker exec -ti galeranode1 service mysql start`

## start the third node (galeranode2 - 172.17.0.12)
`docker run --cap-add=NET_ADMIN --add-host galeranode0:172.17.0.10 --add-host galeranode1:172.17.0.11 --add-host galeranode2:172.17.0.12 --name=galeranode2 -h galeranode2 -dit galera /bin/sh -c "/sbin/ip addr add 172.17.0.12 dev eth0; bash"`  
`docker exec -ti galeranode2 service mysql start`
