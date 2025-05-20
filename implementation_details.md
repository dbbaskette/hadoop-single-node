# Implementation Details: Hadoop Single Node Docker

## Technical Decisions
- **Base Image**: Minimal Linux (e.g., Ubuntu or OpenJDK) with multiarchitecture support (x86_64, ARM64).
- **Hadoop Version**: Latest stable Hadoop (3.x) compatible with single-node operation.
- **Java**: Install OpenJDK (as per Hadoop recommendations).
- **Configuration**:
  - `core-site.xml`: Set `fs.defaultFS` to `hdfs://localhost:9000`
  - `hdfs-site.xml`: Set `dfs.replication` to `1`
- **Single Container**: Both Namenode and Datanode run in one container for simplicity.
- **Ports Exposed**:
  - 9870: Namenode Web UI
  - 9000: Namenode RPC
  - 9864: Datanode Web UI
  - 9866: Datanode Data Transfer
- **Volumes**:
  - `/hadoop/dfs/name`: Namenode data
  - `/hadoop/dfs/data`: Datanode data
  - `/hadoop/logs`: Hadoop logs
- **Entrypoint**: Script checks if namenode is formatted, formats if needed, then starts HDFS daemons.
- **Web UI**: Namenode UI available at http://localhost:9870/

## Steps (from official docs)
1. Install Java.
2. Download and extract Hadoop.
3. Add configuration files (`core-site.xml`, `hdfs-site.xml`).
4. Format the namenode: `hdfs namenode -format` (run once).
5. Start HDFS: `start-dfs.sh` (or manual start scripts).
6. Persist data/logs via Docker volumes.
7. Expose all required ports.

## Status
- Dockerfile and entrypoint script drafted.
- Hadoop config files (`core-site.xml`, `hdfs-site.xml`) created.
- Image is multiarch (amd64, arm64) and only includes HDFS (no YARN/MapReduce).
- See `quick_reference.md` for usage/build/run instructions.
- (Optional) docker-compose.yml can be added for orchestration if needed.
