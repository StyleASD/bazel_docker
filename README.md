# Bazel Base Image

## Description

The idea behind this images is to create a minimal Bazel image to be used in CI/CD Pipelines. The aim overall will be to shrink the repository down to as small as possible making it more portable.

-   docker build -t styleasd/bazel_base:latest -t styleasd/bazel_base:0.22.0 ./
-   docker push styleasd/bazel_base

# Testing

docker run styleasd/bazel_base /bin/sh -c "bazel version"
