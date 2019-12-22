#!/bin/zsh

curl -O -D headers.txt https://developer.allegro.pl/swagger.yaml; EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
  echo problem
  exit $EXIT_CODE
fi

if [ -z "$(diff allegro-openapi.yaml swagger.yaml)" ]; then
  export CHANGED=0
  echo no change
  rm swagger.yaml headers.txt
  exit
else
  export CHANGED=1
fi

# get modification time in HTTP format
MOD_TIME=`grep last-modified headers.txt|cut -c16- - | tr -d '\r'`

# convert to dot separated
NEW_VERSION=`date -j -f '%a, %d %b %Y %T %Z' $MOD_TIME '+%Y.%m.%d'`

# get old version number
OLD_VERSION=`cat VERSION | tr -d "\n"`

if [ $NEW_VERSION = $OLD_VERSION ]; then
  # second run this day
  NEW_VERSION="$NEW_VERSION-1"
elif [ $NEW_VERSION = ${OLD_VERSION[1,10]} ]; then
  num=${OLD_VERSION[12,${#OLD_VERSION}]}
  ((num = $num + 1))
  NEW_VERSION=${NEW_VERSION}-${num}
fi

echo $OLD_VERSION '>' $NEW_VERSION

echo $NEW_VERSION > VERSION
export VERSION=$NEW_VERSION
rm headers.txt
mv swagger.yaml allegro-openapi.yaml
