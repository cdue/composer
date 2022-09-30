FROM composer/composer:2.0.7

RUN set -ex \
  && apk add --no-cache --update --virtual buildDeps build-base autoconf libxml2-dev

RUN docker-php-ext-install soap

RUN yes "" | pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN apk del buildDeps
