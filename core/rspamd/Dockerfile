ARG UBUNTU=rolling
FROM ubuntu:$UBUNTU
MAINTAINER Sebastian Braun <sebastian.braun@fh-aachen.de>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y -q \
    rspamd \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN	echo 'type = "console";' > /etc/rspamd/override.d/logging.inc \
 && echo 'bind_socket = "*:11334";' > /etc/rspamd/override.d/worker-controller.inc \
 && echo 'pidfile = false;' > /etc/rspamd/override.d/options.inc

VOLUME	[ "/var/lib/rspamd" ]
EXPOSE 11333 11334

CMD	[ "/usr/bin/rspamd", "-f", "-u", "_rspamd", "-g", "_rspamd" ]
