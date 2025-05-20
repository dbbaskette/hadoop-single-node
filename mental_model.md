# Mental Model: Hadoop Single Node Setup

This project aims to provide a simple, reproducible, and multiarchitecture-compatible Docker-based setup for running Hadoop HDFS (Namenode and Datanode) on a single local machine. The focus is on:
- Running both Namenode and Datanode in a single container for simplicity.
- Exposing all necessary HDFS ports and the Namenode web UI.
- Persisting HDFS data and logs via Docker volumes.
- Enabling easy use and extension for local development and testing scenarios.

No MapReduce or YARN components are included; only HDFS is provided for lightweight storage and exploration.
