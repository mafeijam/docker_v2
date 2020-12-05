#!/bin/bash

cp env-example .env
mkdir code
touch php-fpm/queue.log
docker-compose build php
docker-compose run --rm composer create-project --prefer-dist laravel/laravel .