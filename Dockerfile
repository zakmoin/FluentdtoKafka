FROM ubuntu:18.04

# update
RUN apt-get update && apt-get -y upgrade

# ruby related packages for td-agent
RUN apt-get -y install curl libcurl4-openssl-dev ruby ruby-dev make sudo gnupg



# install fluentd td-agent
USER root
RUN curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-bionic-td-agent4.sh | sh

# clean cache files
RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# install fluentd plugins


# add conf
COPY fluent.conf /etc/fluentd
CMD td-agent -c /etc/fluentd

#CMD /etc/init.d/td-agent stop && /opt/td-agent/embedded/bin/fluentd -c /etc/fluentd/fluent.conf