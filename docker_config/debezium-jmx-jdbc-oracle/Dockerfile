ARG DEBEZIUM_VERSION
FROM debezium/connect:${DEBEZIUM_VERSION}

ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc 
ENV KAFKA_CONNECT_ES_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-elasticsearch
ENV INSTANT_CLIENT_DIR=/instant_client/

ARG JMX_AGENT_VERSION
ARG POSTGRES_VERSION=42.2.23
ARG KAFKA_JDBC_VERSION=5.5.5

USER root
RUN yum -y install libaio && yum clean all

USER kafka
# Deploy Oracle client and drivers

COPY oracle_instantclient/* $INSTANT_CLIENT_DIR
COPY oracle_instantclient/xstreams.jar /kafka/libs
COPY oracle_instantclient/ojdbc8.jar /kafka/libs

RUN mkdir /kafka/etc && cd /kafka/etc &&\
        curl -so jmx_prometheus_javaagent.jar \
        https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/$JMX_AGENT_VERSION/jmx_prometheus_javaagent-$JMX_AGENT_VERSION.jar

# Deploy PostgreSQL JDBC Driver
RUN cd /kafka/libs && curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar

# Deploy Kafka Connect JDBC
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
	curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar


COPY config.yml /kafka/etc/config.yml
COPY apicurio-registry-utils-converter-2.0.0.Final.jar /kafka/external_libs/apicurio/apicurio-registry-utils-converter-2.0.0.Final.jar
