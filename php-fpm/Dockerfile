FROM php:8-fpm

RUN pecl install redis && docker-php-ext-enable redis

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        zip unzip libzip-dev cron supervisor tini \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql bcmath zip

ENV COMPOSER_HOME /tmp

COPY --from=composer /usr/bin/composer /usr/bin/composer

ARG TZ=Asia/Hong_Kong
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY app.ini /usr/local/etc/php/conf.d

COPY crontab /etc/cron.d/scheduler
RUN chmod 0644 /etc/cron.d/scheduler

COPY queue.conf /etc/supervisor/conf.d/

COPY start.sh /start.sh
RUN chmod 777 /start.sh

ENTRYPOINT [ "/start.sh" ]

WORKDIR /code

ARG UID=1000
ENV UID ${UID}
ARG GID=1000
ENV GID ${GID}

RUN groupmod -o -g ${GID} www-data && usermod -o -u ${UID} -g www-data www-data