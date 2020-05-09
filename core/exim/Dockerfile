ARG UBUNTU=rolling
FROM ubuntu:$UBUNTU

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y -q \
&& apt-get clean \
    exim4-daemon-heavy \
    postgresql-client \
&& rm -rf /var/lib/apt/lists/*
