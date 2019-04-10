FROM alpine

ENV BAZEL_VERSION     0.22.0
ENV JAVA_HOME  /usr/lib/jvm/default-jvm
ENV EXTRA_BAZEL_ARGS  --local_resources 3072,1.0,1.0 --host_javabase=@local_jdk//:jdk

RUN apk add --update \
    && apk --no-cache add \
    g++ \
    libstdc++

RUN apk --no-cache add --virtual .build-deps \
    bash \
    build-base \
    linux-headers \
    python3-dev \
    openjdk8 \
    curl \
    zip
RUN ln -s /usr/bin/python3 /usr/bin/python \
    && mkdir /tmp/bazel \
    && curl --silent --location "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-dist.zip" --output /tmp/bazel-dist.zip \
    && unzip -q -d /tmp/bazel /tmp/bazel-dist.zip

# Install
RUN cd /tmp/bazel \
    && bash compile.sh \
    && cp output/bazel /usr/local/bin/

# Clean
RUN apk del .build-deps \
    && cd / \
    && rm -rf /tmp/bazel*

FROM alpine

COPY --from=build  /usr/local/bin/bazel /usr/local/bin

ENV JAVA_HOME=/opt/jdk

RUN apk --no-cache add \
    g++ \
    libstdc++ \
    openjdk8-jre 
