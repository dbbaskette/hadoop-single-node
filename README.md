# Hadoop Single Node

A containerized single-node Hadoop environment for development, testing, and education.

## Quick Start

1. **Prerequisites**: [Docker](https://www.docker.com/get-started)

2. **Configure Hosts** (one-time setup):
   ```bash
   echo "127.0.0.1   localhost hadoop" | sudo tee -a /etc/hosts
   ```

3. **Build and Run**:
   ```bash
   ./build.sh
   docker run -it --rm \
     --hostname hadoop \
     -p 30800:9000 -p 30870:9870 -p 30866:30866 -p 30864:30864 \
     -v "$PWD/hdfs-site.xml:/etc/hadoop/hdfs-site.xml" \
     -v "$PWD/core-site.xml:/etc/hadoop/core-site.xml" \
     -v "$PWD/hdfs.yaml:/etc/hadoop/hdfs.yaml" \
     hadoop-single-node
   ```

## Access

- **NameNode UI**: http://hadoop:30870
- **DataNode UI**: http://hadoop:30864
- **HDFS RPC**: hdfs://hadoop:30800

## Configuration

| File | Purpose |
|------|---------|
| `hdfs-site.xml` | HDFS configuration |
| `core-site.xml` | Core Hadoop settings |
| `hdfs.yaml` | Extended YAML configuration |

## Documentation

- [Implementation Details](implementation_details.md)
- [Quick Reference](quick_reference.md)
- [Common Issues](gotchas.md)
- [Architecture Overview](mental_model.md)

> Note: Customize configuration files as needed for your environment.
