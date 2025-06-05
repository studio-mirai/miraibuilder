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

# sui,sui-node
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

rm -rf /data/*

CARGO_CMD="cargo build --release --target-dir /data"

IFS=',' read -ra BINS <<< "$BINARIES"
for bin in "${BINS[@]}"; do
  CARGO_CMD+=" --bin $bin"
done

echo "Build Command: $CARGO_CMD"

mkdir -p /data/repo
mkdir -p /data/upload

cd /data && git clone $REPO_URL /data/repo
cd /data/repo && git checkout $COMMIT
cd /data/repo && eval "$CARGO_CMD"

IFS=',' read -ra BINS <<< "$BINARIES"
for bin in "${BINS[@]}"; do
  CARGO_CMD+=" --bin $bin"
  mv /data/release/$bin /data/upload/$bin
  s5cmd --endpoint-url $AWS_ENDPOINT_URL  cp '/data/upload/*' s3://$COMMIT/
done