# vagrant with MariaDB

This directory requires a private repository for Vagrant boxes and MariaDB rpm.
Steps to setup a private CentsOS and mariadb repository:

# 1. read this on hosting Vagrant boxes:
https://github.com/hollodotme/Helpers/blob/master/Tutorials/vagrant/self-hosted-vagrant-boxes-with-versioning.md

# 2. create data dir under /var/www
# 3. change the config file accordingly for auto-indexing.

#
# 4. Get all file to local file.
wget -r --no-parent http://ftp.osuosl.org/pub/mariadb/mariadb-10.1.10/yum/centos/6.6/x86_64/

# 5. put "mariadb" diretory (recursively) onto "data" dir created in previous step.

