#!/bin/bash

setup_git() {
  git config --global user.email "allegro-swagger@travis.example.com"
  git config --global user.name "Travis CI"
}

commit_changes() {
  git add allegro-openapi.yaml VERSION
  git commit --message "New swagger file version: $VERSION"
}

upload_files() {
  git remote add my-origin https://${GH_TOKEN}@github.com/mattesilver/allegro-swagger.git > /dev/null 2>&1
  git push --set-upstream my-origin $TRAVIS_BRANCH
}

setup_git
commit_changes
upload_files
