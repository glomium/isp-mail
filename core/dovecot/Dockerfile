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

# cmd.wait:
#   - name: "sievec {{ hosting.home }}/default.sieve"
#   - watch:
#     - file: /etc/dovecot/default.sieve
#     - file: {{ hosting.home }}/default.sieve
#   - require:
#     - file: /etc/dovecot/default.sieve
#     - file: {{ hosting.home }}/default.sieve

ENTRYPOINT ["dovecot", "-F", "-c/etc/dovecot/dovecot.conf"]
