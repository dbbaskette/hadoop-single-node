# Multiarch Hadoop Single Node Dockerfile
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget tar && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV HADOOP_VERSION=3.4.1 \
    HADOOP_HOME=/opt/hadoop \
    PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin

# Set JAVA_HOME for both possible OpenJDK locations

# Download and extract Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -O /tmp/hadoop.tar.gz && \
    tar -xzf /tmp/hadoop.tar.gz -C /opt && \
    mv /opt/hadoop-$HADOOP_VERSION /opt/hadoop && \
    rm /tmp/hadoop.tar.gz

# Install gettext for envsubst
RUN apt-get update && apt-get install -y gettext && rm -rf /var/lib/apt/lists/*

# Add configuration files
COPY core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml

# Add entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Create data and log directories
RUN mkdir -p /hadoop/dfs/name /hadoop/dfs/data /hadoop/logs && \
    chown -R root:root /hadoop

VOLUME ["/hadoop/dfs/name", "/hadoop/dfs/data", "/hadoop/logs"]

EXPOSE 9870 9000 9864 9866 9867

ENTRYPOINT ["docker-entrypoint.sh"]
