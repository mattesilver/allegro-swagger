#!/usr/bin/env bash

echo 'updating the file'
VERSION=`date "+%Y-%m-%d"`
echo $VERSION > VERSION
export VERSION

mv swagger-new.yaml swagger.yaml

