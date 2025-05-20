#!/bin/bash
set -e

export HADOOP_HOME=/opt/hadoop

# Source JAVA_HOME from /etc/profile.d/java_home.sh if present
if [ -f /etc/profile.d/java_home.sh ]; then
  . /etc/profile.d/java_home.sh
fi

# Fallback: Dynamically detect JAVA_HOME for amd64 or arm64
if [ -z "$JAVA_HOME" ]; then
  if [ -d /usr/lib/jvm/java-11-openjdk-amd64 ]; then
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
  elif [ -d /usr/lib/jvm/java-11-openjdk-arm64 ]; then
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-arm64
  else
    echo "ERROR: Could not find OpenJDK installation directory."
    exit 1
  fi
fi

# Set JAVA_HOME globally for all processes
if grep -q '^JAVA_HOME=' /etc/environment; then
  sed -i "s|^JAVA_HOME=.*|JAVA_HOME=$JAVA_HOME|" /etc/environment
else
  echo "JAVA_HOME=$JAVA_HOME" >> /etc/environment
fi

export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Substitute DATANODE_HOSTNAME in hdfs-site.xml if present
if grep -q '\${DATANODE_HOSTNAME}' "$HADOOP_HOME/etc/hadoop/hdfs-site.xml"; then
  echo "Substituting DATANODE_HOSTNAME in hdfs-site.xml..."
  envsubst < "$HADOOP_HOME/etc/hadoop/hdfs-site.xml" > "$HADOOP_HOME/etc/hadoop/hdfs-site.xml.subst"
  mv "$HADOOP_HOME/etc/hadoop/hdfs-site.xml.subst" "$HADOOP_HOME/etc/hadoop/hdfs-site.xml"
fi

# Format namenode if not already formatted
if [ ! -f /hadoop/dfs/name/current/VERSION ]; then
  echo "Formatting NameNode..."
  $HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive
fi

# Start NameNode and DataNode in foreground
$HADOOP_HOME/bin/hdfs --daemon start namenode
$HADOOP_HOME/bin/hdfs --daemon start datanode

# Wait for HDFS to be available, then set 777 permissions on root
sleep 5
attempts=0
until $HADOOP_HOME/bin/hdfs dfsadmin -safemode get | grep -q 'Safe mode is OFF'; do
  sleep 2
  attempts=$((attempts+1))
  if [ $attempts -gt 15 ]; then
    echo "Timed out waiting for HDFS to leave safe mode."
    break
  fi
  echo "Waiting for HDFS to leave safe mode..."
done

$HADOOP_HOME/bin/hdfs dfs -chmod 777 /

# Tail logs to keep container running
tail -F /hadoop/logs/* &
wait
