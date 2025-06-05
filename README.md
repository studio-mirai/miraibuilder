# MiraiBuilder

First, build the image with the provided Dockerfile and push it to the Fly registry.

```
fly deploy --build-only --push
```

Now you can start a Fly Machine with the uploaded image.

The following environment variables are required:

1. `AWS_ACCESS_KEY_ID` - Credential for uploading binaires to an S3 bucket.
2. `AWS_ENDPOINT_URL` - Endpoint URL for an S3 bucket.
3. `AWS_REGION` - Region for an S3 bucket.
4. `AWS_SECRET_ACCESS_KEY` - Credential for uploading binaires to an S3 bucket.
5. `BINARIES` - A comma-separated string of the binaries to build.
6. `REPO_URL` - GitHub repo containing the source code to build.

```
fly machine run <IMAGE> \
    --env AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID> \
    --env AWS_ENDPOINT_URL=<AWS_ENDPOINT_URL> \
    --env AWS_REGION=<AWS_REGION> \
    --env AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY> \
    --env BINARIES=sui,sui-bridge,sui-node,sui-tool \
    --env REPO_URL=https://github.com/mystenlabs/sui.git \
    --vm-size performance-16x \
    --volume <VOLUME_ID>:/data \
    --rm
```
