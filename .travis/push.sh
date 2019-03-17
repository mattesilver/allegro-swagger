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
  git remote add origin-pages https://${GH_TOKEN}@github.com/mattesilver/allegro-swagger.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-pages gh-pages
}

setup_git
commit_changes
upload_files
