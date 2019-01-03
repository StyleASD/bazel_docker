FROM ubuntu:18.04

WORKDIR /tmp/bazel

RUN apt update \
    && apt install -y pkg-config zip zlib1g-dev unzip wget apt-transport-https ca-certificates curl software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt update \
    && apt install -y docker-ce git make g++ python openjdk-11-jdk


ENV BAZEL_VERSION 0.21.0
ENV PATH "/root/bin:${PATH}"

RUN wget "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh" \
    &&  chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    &&  ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh --user \
    &&  bazel version
