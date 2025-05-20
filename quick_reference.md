# Quick Reference: Hadoop Single Node Docker

## Ports
- 9870: Namenode Web UI (http://localhost:9870/)
- 9000: Namenode RPC
- 9864: Datanode Web UI
- 9866: Datanode Data Transfer

## Volumes
- /hadoop/dfs/name: Namenode data
- /hadoop/dfs/data: Datanode data
- /hadoop/logs: Hadoop logs

## Key Config Files
- `core-site.xml`:
  ```xml
  <configuration>
    <property>
      <name>fs.defaultFS</name>
      <value>hdfs://localhost:9000</value>
    </property>
  </configuration>
  ```
- `hdfs-site.xml`:
  ```xml
  <configuration>
    <property>
      <name>dfs.replication</name>
      <value>1</value>
    </property>
  </configuration>
  ```

## Usage
### Build (multiarch):
```sh
docker buildx build --platform linux/amd64,linux/arm64 -t hadoop-single-node .
```

### Run:
```sh
docker run -p 9870:9870 -p 9000:9000 -p 9864:9864 -p 9866:9866 \
  -v hdfs_name:/hadoop/dfs/name \
  -v hdfs_data:/hadoop/dfs/data \
  -v hadoop_logs:/hadoop/logs \
  hadoop-single-node
```

- Entrypoint: `docker-entrypoint.sh` (auto-formats namenode if needed, starts HDFS)
- Config files: `core-site.xml`, `hdfs-site.xml` (copied into image)
- Data/logs are persisted via Docker volumes
- NameNode Web UI: http://localhost:9870/

See official Hadoop guide for further usage: https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html

## Ignored Files
- instructions.txt
- project-instructions.txt


 docker run --name hadoop -p 9864:30864 -p 9870:30870 -p 8088:30866 -p 9000:30800 --hostname localhost hadoop


