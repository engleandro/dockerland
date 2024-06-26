ARG java_image_tag=17-jre
ARG build_date="$(date -u +'%Y-%m-%d')"
ARG delta_spark_version="3.2.0"
ARG deltalake_version="0.17.4"

FROM eclipse-temurin:${java_image_tag}

# -- Layer: Image Metadata

LABEL org.label-schema.build-date=${build_date}
LABEL org.label-schema.description="Cluster base image"
LABEL org.label-schema.schema-version="1.0"

# -- Layer: OS + Python + Scala

ARG shared_workspace=/opt/workspace

RUN mkdir -p ${shared_workspace}/data \
    && mkdir -p /usr/share/man/man1 \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends curl python3 r-base netcat \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends build-essential manpages-dev python3-pip python3-dev \
    && pip3 install  --no-cache-dir --upgrade pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# We are explicitly pinning the versions of various libraries which this Docker image runs on.
RUN pip3 install --quiet --no-cache-dir delta-spark deltalake
# delta-spark==${delta_spark_version} deltalake==${deltalake_version}

ENV SCALA_HOME="/usr/bin/scala"
ENV PATH=${PATH}:${SCALA_HOME}/bin
ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}

CMD ["bash"]