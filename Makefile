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
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
	docker login -e="." -u="nalipaz" -p="BgyD3v76bbIJDsy1e81KSP3186sRhynzTrhq6eUbBOJPZgqs2EeITPdDy45As5X0" quay.io \
	docker push quay.io/${LOWERCASE_REPO_SLUG}:base; \
	docker push quay.io/${LOWERCASE_REPO_SLUG}:app; \
	docker push quay.io/${LOWERCASE_REPO_SLUG}:mariadb; \
	docker push quay.io/${LOWERCASE_REPO_SLUG}:php-base; \
	docker push quay.io/${LOWERCASE_REPO_SLUG}:php-fpm; \
	docker push quay.io/${LOWERCASE_REPO_SLUG}:httpd; \
	docker push quay.io/${LOWERCASE_REPO_SLUG}:drush; \
	fi
