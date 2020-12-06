FROM php:8-fpm

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        zip \
        unzip \
        cron \
        supervisor \
        procps \
        libzip-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        jpegoptim optipng pngquant gifsicle \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install redis && docker-php-ext-enable redis

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install pdo_mysql bcmath zip gd exif

ENV COMPOSER_HOME /tmp

COPY --from=composer /usr/bin/composer /usr/bin/composer

ARG TZ=Asia/Hong_Kong
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/{$TZ} /etc/localtime && echo {$TZ} > /etc/timezone

WORKDIR /code

ARG UID=1000
ENV UID ${UID}
ARG GID=1000
ENV GID ${GID}

RUN groupmod -o -g ${GID} www-data && usermod -o -u ${UID} -g www-data www-data

COPY app.ini /usr/local/etc/php/conf.d

COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab

COPY queue.conf /etc/supervisor/conf.d/

COPY start.sh /usr/local/bin/start
RUN chmod a+x /usr/local/bin/start

ENTRYPOINT [ "start" ]

CMD [ "php-fpm" ]