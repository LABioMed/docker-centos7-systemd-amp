build:
	docker build -t labiomed/centos7-systemd-amp:base base
	docker build -t labiomed/centos7-systemd-amp:app app
	docker build -t labiomed/centos7-systemd-amp:mariadb mariadb
	docker build -t labiomed/centos7-systemd-amp:php-base php-base
	docker build -t labiomed/centos7-systemd-amp:php-fpm php-fpm
	docker build -t labiomed/centos7-systemd-amp:httpd httpd
	docker build -t labiomed/centos7-systemd-amp:drush drush

version:
	docker run labiomed/drush --version
	docker run labiomed/centos7-systemd-amp:base --version
	docker run labiomed/centos7-systemd-amp:app --version
	docker run labiomed/centos7-systemd-amp:mariadb --version
	docker run labiomed/centos7-systemd-amp:php-base --version
	docker run labiomed/centos7-systemd-amp:php-fpm --version
	docker run labiomed/centos7-systemd-amp:httpd --version
	docker run labiomed/centos7-systemd-amp:drush --version

test:
	@make version