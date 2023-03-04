# Dockerfile
FROM alpine:3.15.4

# Set package versions
ARG AWS_SDK_VERSION=1.11.375
ARG HADOOP_VERSION=3.2.0
ARG SPARK_VERSION=3.1.3
ARG SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop3.2.tgz

# Set download URLs
ARG AWS_SDK_JAR=https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_SDK_VERSION}/aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar
ARG HADOOP_JAR=https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar
ARG SPARK_PACKAGE_URL=https://downloads.apache.org/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}

# Install dependencies
RUN apk update
RUN apk add openjdk8-jre bash snappy

# Install Spark
ADD ${SPARK_PACKAGE_URL} /tmp/
RUN mkdir /opt/spark
RUN tar -zxvf /tmp/$SPARK_PACKAGE -C /opt/spark --strip-components=1
COPY spark-defaults.conf /opt/spark/conf/spark-defaults.conf

# Add libraries to Spark
ADD $AWS_SDK_JAR /opt/spark/jars/
ADD $HADOOP_JAR  /opt/spark/jars/

# Fix snappy library load issue
RUN apk add libc6-compat
RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

# Cleanup
RUN rm -rfv /tmp/*
RUN rm -rf /var/cache/apk/*

# Add Spark tools to path
ENV JAVA_HOME="/usr/lib/jvm/java-1.8-openjdk/jre"
ENV SPARK_HOME="/opt/spark"
ENV PATH="${SPARK_HOME}/bin:${JAVA_HOME}/bin:${PATH}"
CMD ["spark-submit"]
