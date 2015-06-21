FROM debian:wheezy
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV DOCKER_SALT_MINION 20150513

ADD ./bootstrap-salt.sh /bootstrap-salt.sh
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh && chmod 755 /bootstrap-salt.sh
RUN cd /;/bin/sh -c install.sh
# Define default command.
CMD ["bash"]
