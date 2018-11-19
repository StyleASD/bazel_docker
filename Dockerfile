FROM golang:1.10-alpine AS build

RUN apk add --update \
      bash \
      curl \
      dev86 \
      g++ \
      gcc \
      git \
      linux-headers \
      make \
      openjdk8 \
      py-pip \
      python \
      python-dev \
      unzip \
      zip \
      && true \

      && mkdir /out \
      && mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/ \
      
      && apk add --no-cache --initdb --root /out \
      alpine-baselayout \
      busybox \
      ca-certificates \
      coreutils \
      git \
      libc6-compat \
      libgcc \
      libstdc++ \
      python \
      && true

## <snip> build Skaffold, which uses bazel

WORKDIR /out

RUN ln -s /lib /lib64


## <snip> install other runtime dependencies of Skaffold

ENV BAZEL_VERSION 0.19.2
ENV BAZEL_SRC /src/bazel/${BAZEL_VERSION}
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
RUN mkdir -p "${BAZEL_SRC}"
WORKDIR "${BAZEL_SRC}"
RUN curl --silent --location "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-dist.zip" --output bazel-dist.zip \
    && unzip bazel-dist.zip && rm -f bazel-dist.zip

RUN bash compile.sh && mv output/bazel /out/usr/local/bin/bazel


# ===========================================================================================================================================================
# This is the Main image we will be using to run bazel
# ===========================================================================================================================================================

FROM openjdk:8u181-jdk-alpine3.8

RUN apk add --update \
      bash \
      g++ \
      gcc \
      git \
      make \
      docker \
      && true

COPY --from=build  /out /

CMD skaffold

