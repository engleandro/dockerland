ARG image_tag=11-jre-slim

FROM openjdk:${image_tag} as spark-base

# -- Layer: OS + Python 3

ARG shared_workspace=/opt/workspace
ARG build_date="$(date -u +'%Y-%m-%d')"

LABEL org.label-schema.build-date=${build_date}
LABEL org.label-schema.name="Apache Spark cluster"
LABEL org.label-schema.description="Apache Spark cluster-base image"

RUN mkdir -p ${shared_workspace} \
    && apt-get update -y \
    && apt-get install -y python3 python3-pip python3-dev \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}

CMD ["bash"]