FROM debian:buster

# should we use NAT for our clients? - Yes, by default
ENV NAT=1

# default port
ENV PORT=55555

# your server public ip address
ENV PUBLIC_IP=1.2.3.4

# custom dns servers
ENV DNS="1.1.1.1, 1.0.0.1"

# tools
WORKDIR /srv
COPY start addclient /srv/
RUN chmod 755 /srv/*

ENV PATH="/srv:${PATH}"
VOLUME /etc/wireguard

# setup wireguard
RUN chmod 755 /srv/* \
	&& echo "deb http://deb.debian.org/debian/ buster-backports main" > /etc/apt/sources.list.d/buster-backports.list \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends wireguard-tools iptables inotify-tools net-tools qrencode openresolv procps curl \
	&& apt-get clean all

# entrypoint
CMD [ "start" ]
