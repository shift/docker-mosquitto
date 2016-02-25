#!/bin/sh

apk add --update curl jq
cd tmp
projectFile=$(mktemp)
project=$(curl -H "Accept: application/json" https://circleci.com/api/v1/project/shift/docker-alpine-package-mosquitto-auth-plug > $projectFile)

artifactName=$(curl -H "Accept: application/json" https://circleci.com/api/v1/project/shift/docker-alpine-package-mosquitto-auth-plug/$(cat $projectFile | jq '.[0].build_url' | cut -d '"' -f 2 | cut -d '/' -f 7)/artifacts | jq '.[0].url' | cut -d '"' -f 2)
packageName=$(echo $artifactName | cut -d '/' -f 12)

curl -O $artifactName
apk add --allow-untrusted $packageName
rm $projectFile $packageName
apk del jq
