#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_changes() {
  git add swagger.yaml
  git commit --message "New swagger file version: $VERSION"
}

upload_files() {
  git push master
}

setup_git
commit_changes
upload_files
