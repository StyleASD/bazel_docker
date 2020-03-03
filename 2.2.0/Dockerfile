FROM openjdk:11.0.6-slim-buster

ENV BAZEL_VERSION 2.2.0
ENV PATH "/root/bin:${PATH}"

WORKDIR /tmp/bazel

RUN apt update \
    && apt install -y curl zip \
    && curl --silent --location "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh" --output bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
    && chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    &&  ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh --user \
    && rm ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh gpg \
    rm -rf /var/lib/apt/lists/* \
    && apt remove -y --purge curl zip
