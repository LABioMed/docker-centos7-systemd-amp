build:
	docker build -t ${LOWERCASE_REPO_SLUG}:base base
	docker build -t ${LOWERCASE_REPO_SLUG}:app app
	docker build -t ${LOWERCASE_REPO_SLUG}:mariadb mariadb
	docker build -t ${LOWERCASE_REPO_SLUG}:php-base php-base
	docker build -t ${LOWERCASE_REPO_SLUG}:php-fpm php-fpm
	docker build -t ${LOWERCASE_REPO_SLUG}:httpd httpd
	docker build -t ${LOWERCASE_REPO_SLUG}:drush drush

push:
	if [ "${TRAVIS_BRANCH}" == "master" ]; then
		docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USER" -p="$DOCKER_PASS"
		docker push ${LOWERCASE_REPO_SLUG};
	fi