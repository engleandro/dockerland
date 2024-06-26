FROM spark:latest

ARG SPARK_WORKER_WEB_UI=8080

EXPOSE ${SPARK_WORKER_WEB_UI}

CMD bin/spark-class org.apache.spark.deploy.worker.Worker spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}  >> logs/spark-worker.out