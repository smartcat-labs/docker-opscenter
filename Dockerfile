# Version 1.0

FROM openjdk:8
ARG DSE_USERNAME
ARG DSE_PASSWORD
ARG OPSCENTER_VERSION

MAINTAINER Nenad Bozic <nenad.bozic@smartcat.io>

# Download and extract OpsCenter
RUN \
  mkdir -p /opt/opscenter; \
  wget --user $DSE_USERNAME --password $DSE_PASSWORD -O - http://downloads.datastax.com/enterprise/opscenter-$OPSCENTER_VERSION.tar.gz \
  | tar xzf - --strip-components=1 -C "/opt/opscenter";

COPY	. /src

# Copy over daemons
RUN	\
  mkdir -p /etc/service/opscenter; \
  cp /src/run /etc/service/opscenter/; \
  ln -s /opt/opscenter/log /var/log/opscenter;

# Expose ports
EXPOSE 8888 61620

WORKDIR /opt/opscenter

ENTRYPOINT ["/etc/service/opscenter/run"]
CMD ["opscenter"]

# Clean up
RUN apt-get clean && rm -rf /tmp/* /var/tmp/*
