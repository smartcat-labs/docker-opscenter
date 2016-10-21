# Version 1.0

FROM phusion/baseimage:latest
ARG DSE_USERNAME
ARG DSE_PASSWORD
ARG OPSCENTER_VERSION

MAINTAINER Nenad Bozic <nenad.bozic@smartcat.io>

# Download and extract OpsCenter
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update; apt-get upgrade -y -qq; \
  apt-get install -y -qq wget oracle-java8-installer; \
  mkdir /opt/opscenter; \
  wget --user $DSE_USERNAME --password $DSE_PASSWORD -O - http://downloads.datastax.com/enterprise/opscenter-$OPSCENTER_VERSION.tar.gz \
  | tar xzf - --strip-components=1 -C "/opt/opscenter";

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ADD	. /src

# Copy over daemons
RUN	\
  mkdir -p /etc/service/opscenter; \
  cp /src/run /etc/service/opscenter/; \
  ln -s /opt/opscenter/log /var/log/opscenter;

# Expose ports
EXPOSE 8888
EXPOSE 61620

WORKDIR /opt/opscenter

CMD ["/sbin/my_init"]

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/oracle-jdk8-installer /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
