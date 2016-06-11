build:
	docker build -t $TRAVIS_REPO_SLUG:base base && docker push $DOCKER_IMAGE_NAME
	docker build -t $TRAVIS_REPO_SLUG:app app
	docker build -t $TRAVIS_REPO_SLUG:mariadb mariadb
	docker build -t $TRAVIS_REPO_SLUG:php-base php-base
	docker build -t $TRAVIS_REPO_SLUG:php-fpm php-fpm
	docker build -t $TRAVIS_REPO_SLUG:httpd httpd
	docker build -t $TRAVIS_REPO_SLUG:drush drush

version:
	docker run $TRAVIS_REPO_SLUG:base --version
	docker run $TRAVIS_REPO_SLUG:app --version
	docker run $TRAVIS_REPO_SLUG:mariadb --version
	docker run $TRAVIS_REPO_SLUG:php-base --version
	docker run $TRAVIS_REPO_SLUG:php-fpm --version
	docker run $TRAVIS_REPO_SLUG:httpd --version
	docker run $TRAVIS_REPO_SLUG:drush --version

test:
	@make version

push:
	if [ "$TRAVIS_BRANCH" == "master" ]; then
		docker push $TRAVIS_REPO_SLUG;
	fi