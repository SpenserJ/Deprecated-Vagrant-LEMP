Vagrant-LEMP Stack
==================

Default LEMP development stack configuration for Vagrant.

Usage:
------

Download and install Vagrant and VirtualBox from http://vagrantup.com and https://www.virtualbox.org/ respectively.

Clone this repository and launch Vagrant box:
```
$ git clone --recursive git://github.com/SpenserJ/Vagrant-LEMP.git [repo]
$ cd [repo]
$ vagrant up
```

What's Inside:
--------------

Installed software:
+ Ubuntu 12.04 (64-bit) 
+ nginx 1.2.6 (ppa: https://launchpad.net/~nginx/+archive/stable)
+ mysql 5.5
+ php 5.4.3 (ppa: https://launchpad.net/~ondrej/+archive/php5)
+ ajenti 0.6.1
+ git
