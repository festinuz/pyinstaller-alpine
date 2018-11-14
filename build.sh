#!/bin/bash

export PYTHON_VERSION=${1:-3.6}
export ALPINE_VERSION=${2:-3.6}
REPO="festinuz/pyinstaller-alpine:$PYTHON_VERSION-$ALPINE_VERSION"

echo "python: $PYTHON_VERSION"
echo "alpine: $ALPINE_VERSION"

docker build \
    --build-arg PYTHON_VERSION=$PYTHON_VERSION \
    --build-arg ALPINE_VERSION=$ALPINE_VERSION \
    -t $REPO .

docker push $REPO
