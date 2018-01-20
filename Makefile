.PHONY: all
all: test

.PHONY: dependencies
dependencies:
	echo "dependencies"

.PHONY: test
test:
	echo "tests"

.PHONY: build
build:
	echo "build"

.PHONY: deploy
deploy: test build
	echo "deploy"
