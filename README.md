# CentOS 7, Systemd, and AMP (**A**pache, **M**ysql, **P**HP)

[![Join the chat at https://gitter.im/LABioMed/docker-centos7-systemd-amp](https://badges.gitter.im/LABioMed/docker-centos7-systemd-amp.svg)](https://gitter.im/LABioMed/docker-centos7-systemd-amp?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Images all based on CentOS 7 (official image). These images together are great for running a full Drupal stack but could certainly be used for most any LAMP-based web application.
## Build Status
GitHub Repo: [![GitHub commits](https://img.shields.io/github/commits-since/LABioMed/docker-centos7-systemd-amp/99fbe19f80ef67d24018921e74d1c92808519178.svg?maxAge=2592000&label=commits)](https://github.com/LABioMed/docker-centos7-systemd-amp)  
Docker Pulls: [![Docker Pulls](https://img.shields.io/docker/pulls/labiomed/centos7-systemd-amp.svg?maxAge=2592000)](https://hub.docker.com/r/labiomed/centos7-systemd-amp/)  
Docker Stars: [![Docker Stars](https://img.shields.io/docker/stars/labiomed/centos7-systemd-amp.svg?maxAge=2592000)](https://hub.docker.com/r/labiomed/centos7-systemd-amp/)  
Travis CI: [![Build Status](https://travis-ci.org/LABioMed/docker-centos7-systemd-amp.svg?branch=master)](https://travis-ci.org/LABioMed/docker-centos7-systemd-amp)  
Quay: [![Docker Repository on Quay](https://quay.io/repository/labiomed/centos7-systemd-amp/status "Docker Repository on Quay")](https://quay.io/repository/labiomed/centos7-systemd-amp)  

## About this repo
Each service is available as a different tag here and should be used as a base image for your own custom image. The images available are:

 * base: the base image that sets up CentOS and systemd, everything else is based on this.
 * app: meant to be an image to contain shared volumes as well as the web application files.
 * mariadb: MariaDB 10.1 (official, not the CentOS repo)
 * php-base: PHP 5.5, includes php-cli. Having this separate from php-fpm allows us to base other images off of it sans-php-fpm.
 * php-fpm: PHP FastCGI Process Manager, based on php-base image.
 * httpd: Apache 2.4
 * drush: Drush 8.1, this is based on the php-base image.

## Build Arguments
All the images expect some number of build arguments when building them. For that reason it is best that these are built together using Vagrant, Docker Compose, or similar (see usage below). Here we outline the expected build arguments, which can also be seen in the Dockerfile for each image:

 * base: none, this is so we can do everything in the sub-images during `ONBUILD`, allowing you to avoid unnecessary modifications.  
 * app:  
   `USERNAME`: User to create, this should be consistent on each image typically.  
   `UID`: uid for the above user, typically you will want to use the same uid as your own on the host, in our Vagrantfile we do `ENV['UID'] = Etc.getpwnam("#{ENV['USER']}").uid.to_s`  
 * mariadb:  
   `MARIADB_USER`:  A username to create an initial database with.  
   `MARIADB_PASS`: The aforementioned user's database password.  
   `MARIADB_DATABASE`: The name of an initial database to create.  
   `MARIADB_ROOT_PASS`: The root user's password.  
 * php-base: none.  
 * php-fpm: same as app above.  
 * httpd:  
   `USERNAME`: same as app above  
   `UID`: same as app above  
   `DOMAINNAME`: the domain name you wish to use on the site you are hosting in these containers.  
   `PHPFPMSERVER`: the name of the php-fpm server after it is provisioned, this is needed to be able to make a connection to it.  
 * drush:  
   `USERNAME`: same as app above  
   `UID`: same as app above  
   `DOMAINNAME`: same as httpd above  
   `PORT`: the port that httpd is running on  

## Usage
All machines need the volume `/sys/fs/cgroup:/sys/fs/cgroup:ro` set when running. [See the example Vagrantfile](https://github.com/LABioMed/docker-centos7-systemd-amp-vagrant).

## Vagrant Example
### Prerequisites
Ruby gem `etc`. Needs to be installed via vagrant plugins: 
```
vagrant plugin install etc
```
Additionally, I have only tested this on a Debian 7 host machine. I can not make any guarantees for support on other systems.

### Usage
There is an [example repository](https://github.com/LABioMed/docker-centos7-systemd-amp-vagrant) which should be fairly self-explanatory. You only need to clone the [example repository](https://github.com/LABioMed/docker-centos7-systemd-amp-vagrant) and run `vagrant up` from within the clone to test this out.
