# Bazel Base Image

## Description

The idea behind this images is to create a minimal Bazel image needed to run the command `bazel version`. You will then need to add additional packages to your images inorder to get the application to run e.g if you are running rules_docker you will need docker installed to push to your remote repositories

-   docker build -t styleasd/bazel:latest -t styleasd/bazel:0.24.0 ./
-   docker push styleasd/baze

# Testing

docker run styleasd/bazel /bin/sh -c "bazel version"
