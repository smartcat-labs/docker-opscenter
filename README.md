# Docker image for DataStax Enterprise OpsCenter

This is Dockerfile which will build DataStax Enterprise OpsCenter image.

From version 6.x two major changes happen:
- OpsCenter is downloadable only with email and password for DSE customers
- OpsCenter is Java application and it was Python application previously

All Docker images on DockerHub are for 5.x version which is free for all Cassandra
users and it is Python application. This Dockerfile can be used to build image
for latest OpsCenter.

## Build
```
docker build --build-arg DSE_USERNAME=<dse_username> --build-arg DSE_PASSWORD=<dse_password> --build-arg OPSCENTER_VERSION=<opscenter_version> -t opscenter:<opscenter_version> .
```
To build this image you need to specify three arguments:
- DSE_USERNAME - username of account which has DSE licence
- DSE_PASSWORD - password of account which has DSE licence
- OPSCENTER_VERSION - version of OpsCenter
