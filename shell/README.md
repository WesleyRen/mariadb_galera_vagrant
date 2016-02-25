**How to**
=========================
1. Install [Vagrant](https://www.vagrantup.com/) & [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Clone this repo.
3. run:
```
cd [pub-repo|priv-repo] # choose one, if you don't know, use pub_repo
vagrant up
```

**Files:**
 * VagrantFile   --> setup CentOS VM (6.7)
 * bootstrap.sh  --> setup MariaDB 10.1.10, which comes with Galera.

**Troubleshooting**
1. Make sure you have latest version of Vagrant and VirtualBox.

**Other notes**
1. To shutdown, use: "vagrant halt db1 db2 db3"
2. To start, use: "vagrant up db1; vagrant up db2 db3" -- we need to bring up db1 first as first node.
