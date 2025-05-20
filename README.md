# Hadoop Single Node Project

This project provides a single-node Hadoop environment, suitable for development, testing, and educational purposes. It is containerized with Docker for ease of setup and management.

## Features
- Single-node Hadoop deployment
- Customizable HDFS configuration (`hdfs-site.xml`, `core-site.xml`, `hdfs.yaml`)
- Docker-based setup for quick start
- Helpful reference and implementation documentation

## Getting Started

### Prerequisites
- [Docker](https://www.docker.com/get-started) installed on your system

### Build and Run
```sh
# Build the Docker image
./build.sh

# Run the container
# (You may need to adjust volume mounts or ports as needed)
docker run -it --rm \
  -v "$PWD/hdfs-site.xml:/etc/hadoop/hdfs-site.xml" \
  -v "$PWD/core-site.xml:/etc/hadoop/core-site.xml" \
  -v "$PWD/hdfs.yaml:/etc/hadoop/hdfs.yaml" \
  hadoop-single-node
```

### Entrypoint
The container uses `docker-entrypoint.sh` to initialize and start Hadoop services. You can modify this script for custom startup behavior.

## Configuration Files
- `hdfs-site.xml`: HDFS configuration
- `core-site.xml`: Core Hadoop configuration
- `hdfs.yaml`: Additional YAML-based configuration

## Documentation
- [`quick_reference.md`](./quick_reference.md): Quick commands and tips
- [`implementation_details.md`](./implementation_details.md): Deeper technical details
- [`gotchas.md`](./gotchas.md): Common pitfalls and troubleshooting
- [`mental_model.md`](./mental_model.md): Conceptual overview

## Additional Notes
- See `instructions.txt` for more detailed instructions or advanced usage.
- All configuration files can be customized as needed for your environment.

---

*Generated on 2025-05-16. Update this README as your project evolves.*
