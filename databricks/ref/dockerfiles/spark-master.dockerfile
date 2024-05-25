ARG spark_version

# FROM spark-base:${spark_version}
FROM spark-base:latest

# -- Layer: Image Metadata

ARG build_date

ENV build_date="$(date -u +'%Y-%m-%d')"

LABEL org.label-schema.build-date=${build_date}
LABEL org.label-schema.description="Spark master image"
LABEL org.label-schema.schema-version="1.0"

# -- Runtime

EXPOSE 8080 7077

CMD bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out