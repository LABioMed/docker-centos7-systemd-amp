build:
	docker build -t ${LOWERCASE_REPO_SLUG}:base base
	docker build -t ${LOWERCASE_REPO_SLUG}:app app
	docker build -t ${LOWERCASE_REPO_SLUG}:mariadb mariadb
	docker build -t ${LOWERCASE_REPO_SLUG}:php-base php-base
	docker build -t ${LOWERCASE_REPO_SLUG}:php-fpm php-fpm
	docker build -t ${LOWERCASE_REPO_SLUG}:httpd httpd
	docker build -t ${LOWERCASE_REPO_SLUG}:drush drush

version:
	docker run ${LOWERCASE_REPO_SLUG}:base --version
	docker run ${LOWERCASE_REPO_SLUG}:app --version
	docker run ${LOWERCASE_REPO_SLUG}:mariadb --version
	docker run ${LOWERCASE_REPO_SLUG}:php-base --version
	docker run ${LOWERCASE_REPO_SLUG}:php-fpm --version
	docker run ${LOWERCASE_REPO_SLUG}:httpd --version
	docker run ${LOWERCASE_REPO_SLUG}:drush --version

test:
	@make version

push:
	if [ "${TRAVIS_BRANCH}" == "master" ]; then
		docker push ${LOWERCASE_REPO_SLUG};
	fi