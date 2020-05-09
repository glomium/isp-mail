ARG UBUNTU=rolling
FROM ubuntu:$UBUNTU

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y -q \
    dovecot-core \
    dovecot-imapd \
    dovecot-pop3d \
    dovecot-managesieved \
    dovecot-lmtpd \
    dovecot-pgsql \
    postgresql-client \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

COPY core/dovecot/dovecot.conf core/dovecot/dovecot-sql.conf.ext core/dovecot/default.sieve /etc/dovecot/
COPY core/dovecot/conf.d /etc/dovecot/conf.d

ENTRYPOINT ["dovecot", "-F", "-c/etc/dovecot/dovecot.conf"]
