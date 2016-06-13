build:
	docker build -t ${DOCKER_REGISTRY}/${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:\${tag} \${tag}; \

run:
	docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${DOCKER_REGISTRY}/${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${tag} /usr/lib/systemd/systemd

test:
	@make run

push_quay:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
	  docker login -e="${QUAY_EMAIL}" -u="${QUAY_USER}" -p="${QUAY_PASS}" quay.io; \
	  docker push ${DOCKER_REGISTRY}/${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${tag}; \
	fi

push_hub:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
	  docker login -e="${DOCKER_HUB_EMAIL}" -u="${DOCKER_HUB_USER}" -p="${DOCKER_HUB_PASS}"; \
	  docker tag ${DOCKER_REGISTRY}/${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${tag} ${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${tag}; \
	  docker push ${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${tag}; \
	fi
