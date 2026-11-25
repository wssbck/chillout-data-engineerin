# syntax=docker/dockerfile:1

# Stage 1: Iceberg/Parquet jars for Spark.
# BuildKit builds it in parallel with the Python stage.
FROM debian:trixie-slim AS jars

ARG MAVEN_REPO=https://repo1.maven.org/maven2
ARG ICEBERG_VERSION=1.12.0
ARG ICEBERG_SPARK_RUNTIME_VERSION=4.1_2.13
ARG PARQUET_AVRO_VERSION=1.18.2

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates

WORKDIR /jars
RUN wget -q ${MAVEN_REPO}/org/apache/iceberg/iceberg-aws-bundle/${ICEBERG_VERSION}/iceberg-aws-bundle-${ICEBERG_VERSION}.jar && \
    wget -q ${MAVEN_REPO}/org/apache/iceberg/iceberg-spark-runtime-${ICEBERG_SPARK_RUNTIME_VERSION}/${ICEBERG_VERSION}/iceberg-spark-runtime-${ICEBERG_SPARK_RUNTIME_VERSION}-${ICEBERG_VERSION}.jar && \
    wget -q ${MAVEN_REPO}/org/apache/iceberg/iceberg-spark-extensions-${ICEBERG_SPARK_RUNTIME_VERSION}/${ICEBERG_VERSION}/iceberg-spark-extensions-${ICEBERG_SPARK_RUNTIME_VERSION}-${ICEBERG_VERSION}.jar && \
    wget -q ${MAVEN_REPO}/org/apache/parquet/parquet-avro/${PARQUET_AVRO_VERSION}/parquet-avro-${PARQUET_AVRO_VERSION}.jar

# Stage 2: runtime image
FROM python:3.14-trixie

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV SPARK_HOME=/usr/local/lib/python3.14/site-packages/pyspark
RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# system packages: headless JRE is enough for Spark; libnss-wrapper for the entrypoint
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends jq openjdk-21-jre-headless libnss-wrapper

# Python dependencies (pip's download cache persists across builds)
COPY requirements.txt /tmp/requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

# Spark jars from the jars stage; the pip package ships no conf/ directory, so create it
RUN mkdir -p ${SPARK_HOME}/conf
COPY --from=jars /jars/ ${SPARK_HOME}/jars/

# configure Spark logging
COPY log4j2.properties ${SPARK_HOME}/conf/

# keep Spark's default warehouse out of the notebooks' folders (ephemeral, in the container)
COPY spark-defaults.conf ${SPARK_HOME}/conf/

# support running as an arbitrary (host) UID
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
