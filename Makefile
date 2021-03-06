.PHONY: all
all: dependencies test

.PHONY: dependencies
dependencies:
	bundle install
	bundle exec pod install

.PHONY: test
test:
	bundle exec fastlane tests

.PHONY: build
build:
	echo "build"

.PHONY: deploy
deploy: test build
	echo "deploy"
