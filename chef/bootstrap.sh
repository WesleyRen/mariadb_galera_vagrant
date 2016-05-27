#!/usr/bin/env bash

## For CentOS
yum clean all
yum -y update

# do we need this? what does this mean?
rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB


# local network: I have a local repo setup.
# See more at: http://mariadb.org/mariadb/repositories/
echo "[mariadb]"                                > /etc/yum.repos.d/MariaDB.repo
echo "name = MariaDB"                          >> /etc/yum.repos.d/MariaDB.repo
echo "baseurl = http://10.65.228.71/data/mariadb/mariadb-10.1.10/yum/centos/6.6/x86_64" >> /etc/yum.repos.d/MariaDB.repo
echo "gpgkey=http://10.65.228.71/data/mariadb/mariadb-10.1.10/yum/centos/6.6/x86_64/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo
echo "gpgcheck=1"                              >> /etc/yum.repos.d/MariaDB.repo

yum -y install MariaDB-server MariaDB-client
#yes | yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm

echo "#
# This group is read both both by the client and the server
# use it for options that affect everything
#
[client-server]

#
# include all files from the config directory
#
!includedir /etc/my.cnf.d
" > /etc/my.cnf

mkdir -p /etc/my.cnf.d

export db1_ip=192.168.50.101
export db2_ip=192.168.50.102
export db3_ip=192.168.50.103
# set HOST_IP as sst_receive_address
if [ $HOSTNAME == "db1" ]; then
  export HOST_IP=$db1_ip
elif [ $HOSTNAME == "db2" ]; then
  export HOST_IP=$db2_ip
elif [ $HOSTNAME == "db3" ]; then
  export HOST_IP=$db3_ip
fi

# set ip list for cluster_address -- we need a first node, db1, which is different.
if [ $HOSTNAME == "db1" ]; then
  export ip_list=""
else
  export ip_list=$db1_ip,$db2_ip,$db3_ip
fi


echo "[mysqld]
user=mysql
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
bind-address=0.0.0.0
innodb_flush_log_at_trx_commit=0
innodb_buffer_pool_size=122M
binlog_format=ROW
default_storage_engine=innodb
innodb_autoinc_lock_mode=2
innodb_doublewrite=1
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
wsrep_cluster_name=my_cluster
wsrep_cluster_address=gcomm://$ip_list
wsrep_slave_threads=2
wsrep_sst_method=rsync
wsrep_sst_auth=vagrant:vagrant
wsrep_sst_receive_address=$HOST_IP
wsrep_on=ON" > /etc/my.cnf.d/server.cnf

if [ $HOSTNAME == "db1" ]; then
  nohup mysqld --wsrep-new-cluster > /tmp/mysqld.log 2>&1 &
else
  nohup mysqld --wsrep_cluster_address=gcomm://192.168.50.101 > /tmp/mysqld.log 2>&1 &
fi

