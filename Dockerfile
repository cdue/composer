FROM php:7.3.33-alpine3.14

RUN set -eux \
  && apk add --no-cache --update --virtual buildDeps build-base autoconf curl

RUN set -eux \
  && apk add --no-cache --update libxml2-dev tini

RUN printf "# composer php cli ini settings\n\
date.timezone=UTC\n\
memory_limit=-1\n\
" > $PHP_INI_DIR/php-cli.ini

# INSTALL COMPOSER 2.0.7
RUN curl \
    --silent \
    --fail \
    --location \
    --retry 3 \
    --output /usr/local/bin/composer \
    --url https://getcomposer.org/download/2.0.7/composer.phar
RUN chmod 755 /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 2.0.7

RUN docker-php-ext-install soap

RUN yes "" | pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN apk del buildDeps

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["composer"]
