build:
	docker build -t ${LOWERCASE_REPO_SLUG}:base base
	docker build -t ${LOWERCASE_REPO_SLUG}:app app
	docker build -t ${LOWERCASE_REPO_SLUG}:mariadb mariadb
	docker build -t ${LOWERCASE_REPO_SLUG}:php-base php-base
	docker build -t ${LOWERCASE_REPO_SLUG}:php-fpm php-fpm
	docker build -t ${LOWERCASE_REPO_SLUG}:httpd httpd
	docker build -t ${LOWERCASE_REPO_SLUG}:drush drush

run:
	docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${LOWERCASE_REPO_SLUG}:base /usr/lib/systemd/systemd
	docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${LOWERCASE_REPO_SLUG}:app /usr/lib/systemd/systemd
	docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${LOWERCASE_REPO_SLUG}:mariadb /usr/lib/systemd/systemd
	docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${LOWERCASE_REPO_SLUG}:php-base /usr/lib/systemd/systemd
	docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${LOWERCASE_REPO_SLUG}:php-fpm /usr/lib/systemd/systemd
	docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${LOWERCASE_REPO_SLUG}:httpd /usr/lib/systemd/systemd
	docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${LOWERCASE_REPO_SLUG}:drush /usr/lib/systemd/systemd

test:
	@make run

push:
	if [ "${TRAVIS_BRANCH}" == "master" ]; then
  docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USER" -p="$DOCKER_PASS"
  docker push ${LOWERCASE_REPO_SLUG};
	fi