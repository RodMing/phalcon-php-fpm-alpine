#
# PHP-FPM 7.1.5 Dockerfile
#

# Pull base image
FROM php:fpm-alpine

MAINTAINER Rodrigo Mingattos <rodrigo_mingattos@hotmail.com>

ENV PHALCON_VERSION=3.1.2

RUN apk add --update --virtual build-dependencies \
	autoconf \
	file \
	g++ \
	gcc \
	make \
	pcre-dev \
	re2c

COPY phalcon-v$PHALCON_VERSION .
RUN tar xvzf phalcon-v$PHALCON_VERSION
RUN cd cphalcon-$PHALCON_VERSION/build && sh install
RUN echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/50-phalcon.ini
RUN rm -rf cphalcon-$PHALCON_VERSION \
	phalcon-v$PHALCON_VERSION \
	/var/cache/apk/* \
        /tmp/* \
        /var/tmp/*

RUN apk del build-dependencies
