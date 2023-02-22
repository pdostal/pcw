# Default container tag
CONT_TAG=suse/qac/pcw

.PHONY: all
all: prepare test

.PHONY: prepare
prepare:
	pip install -r requirements_test.txt

.PHONY: test
test:
	pytest --cov

.PHONY: codecov
codecov:
	pytest -v --cov --cov-report=html && xdg-open htmlcov/index.html

# Build containers
docker-container:
	docker build . -t ${CONT_TAG}
podman-container:
	podman build . -t ${CONT_TAG}
podman-container-devel:
	podman build -f Dockerfile_dev -t pcw-devel
podman-container-k8s:
	podman build -f Dockerfile_k8s -t pcw-k8s-cleaner
podman-container-k8s-devel:
	podman build -f Dockerfile_k8s_dev -t pcw-k8s-cleaner-devel
