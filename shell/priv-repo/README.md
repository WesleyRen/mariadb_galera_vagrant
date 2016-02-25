How to setup a private CentsOS and mariadb repository:

# vagrant with MariaDB
# read this on hosting Vagrant boxes:
https://github.com/hollodotme/Helpers/blob/master/Tutorials/vagrant/self-hosted-vagrant-boxes-with-versioning.md

create data dir under /var/www
change the config file accordingly for auto-indexing.

#
# Get all file to local file.
wget -r --no-parent http://ftp.osuosl.org/pub/mariadb/mariadb-10.1.10/yum/centos/6.6/x86_64/

# and put "mariadb" diretory (recursively) onto "data" dir created in previous step.

