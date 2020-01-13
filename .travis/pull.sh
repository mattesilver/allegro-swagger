#!/bin/bash

FILE_NEW=swagger.yaml
FILE=allegro-openapi.yaml

curl -O https://developer.allegro.pl/swagger.yaml; EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
  echo problem
  exit $EXIT_CODE
fi

if [ -z "$(diff $FILE $FILE_NEW)" ]; then
  export CHANGED=0
  echo no change
  rm $FILE_NEW
  exit
else
  export CHANGED=1
  mv $FILE_NEW $FILE
fi

NEW_VERSION=$(date "+%Y.%m.%d")
OLD_VERSION=`cat VERSION | tr -d "\n"`

if [ "$OLD_VERSION" ] && [ "$NEW_VERSION" = $OLD_VERSION ]; then
  # second run this day
  NEW_VERSION="$NEW_VERSION-1"
elif [ "$NEW_VERSION" = "${OLD_VERSION:0:10}" ]; then
  num=${OLD_VERSION:11:1}
  num=$(($num + 1))
  NEW_VERSION="${NEW_VERSION}-${num}"
fi

echo $OLD_VERSION '=>' $NEW_VERSION

echo $NEW_VERSION > VERSION
export VERSION=$NEW_VERSION
