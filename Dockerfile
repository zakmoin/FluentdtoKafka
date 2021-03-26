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
COPY start.sh /tmp/start.sh
#RUN useradd fluent
#RUN usermod -aG sudo fluent
#USER fluent
# This is the command to start fluentd
USER root
RUN chmod a+x /tmp/start.sh
CMD /tmp/start.sh


#CMD /etc/init.d/td-agent stop && /opt/td-agent/embedded/bin/fluentd -c /etc/fluentd/fluent.conf