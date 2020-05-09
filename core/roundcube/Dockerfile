ARG UBUNTU=rolling
FROM ubuntu:$UBUNTU

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y -q \
    apache2 \
    ca-certificates \
    wget \
    roundcube-pgsql \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

ARG VERSION=1.4.4
WORKDIR /var/www

RUN wget https://github.com/roundcube/roundcubemail/releases/download/$VERSION/roundcubemail-$VERSION-complete.tar.gz -O roundcube.tar.gz -q \
 && tar -xzf roundcube.tar.gz \
 && rm roundcube.tar.gz \
 && mv roundcubemail-${VERSION} roundcube \
 && mkdir /var/run/apache2

COPY core/roundcube/config.inc.php /var/www/roundcube/config/config.inc.php

# Setup Webserver
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

COPY core/roundcube/ports.conf core/roundcube/apache2.conf /etc/apache2/
COPY core/roundcube/default.conf /etc/apache2/sites-enabled/000-default.conf

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y -q \
    vim \
&& apt-get clean

EXPOSE 8080/tcp
ENTRYPOINT ["apache2", "-DFOREGROUND"]
