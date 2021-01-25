FROM composer/composer:2.0.7

RUN set -ex \
  && apk update \
  && apk --no-cache add libxml2-dev

RUN docker-php-ext-install soap
