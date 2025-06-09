#!/bin/bash

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    echo "AWS_ACCESS_KEY_ID is not set"
    exit 1
fi

if [ -z "$AWS_ENDPOINT_URL" ]; then
    echo "AWS_ENDPOINT_URL is not set"
    exit 1
fi

if [ -z "$AWS_REGION" ]; then
    echo "AWS_REGION is not set"
    exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "AWS_SECRET_ACCESS_KEY is not set"
    exit 1
fi

if [ -z "$BINARIES" ]; then
    echo "BINARIES is not set"
    exit 1
fi

if [ -z "$COMMIT" ]; then
    echo "COMMIT is not set"
    exit 1
fi

if [ -z "$REPO_URL" ]; then
    echo "REPO_URL is not set"
    exit 1
fi

if [ -z "$VOLUME_ID" ]; then
    echo "VOLUME_ID is not set"
    exit 1
fi

fly machine run registry.fly.io/miraibuilder:deployment-01JWYTBJEF6ASDD60B152J67BD \
    --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    --env AWS_ENDPOINT_URL=$AWS_ENDPOINT_URL \
    --env AWS_REGION=$AWS_REGION \
    --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    --env BINARIES=$BINARIES \
    --env COMMIT=$COMMIT \
    --env REPO_URL=$REPO_URL \
    --vm-size performance-16x \
    --volume $VOLUME_ID:/data \
    --rm