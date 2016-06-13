build:
	for image in ${DOCKER_IMAGES}; do \
	  docker build -t ${DOCKER_REGISTRY}/${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${image} ${image}; \
	done

run:
	for image in ${DOCKER_IMAGES}; do \
	  docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${DOCKER_REGISTRY}/${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${image} /usr/lib/systemd/systemd
	done

test:
	@make run

push_quay:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
	  docker login -e="${QUAY_EMAIL}" -u="${QUAY_USER}" -p="${QUAY_PASS}" quay.io; \
	  for image in ${DOCKER_IMAGES}; do \
	    docker push ${DOCKER_REGISTRY}/${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${image}; \
	  done
	fi

push_hub:
	if [ "${TRAVIS_BRANCH}" = "master" ]; then \
	  docker login -e="${DOCKER_HUB_EMAIL}" -u="${DOCKER_HUB_USER}" -p="${DOCKER_HUB_PASS}"; \
	  for image in ${DOCKER_IMAGES}; do \
	    docker tag ${DOCKER_REGISTRY}/${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${image} ${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${image}; \
	    docker push ${DOCKER_REPO_USERNAME}/${DOCKER_REPO_SLUG}:${images[i]}; \
	  done
	fi
