#!/bin/bash
export APP_ENV="production"
docker image rm thinktran/php:php8.4-frankenphp-opcache -f
docker build --no-cache -t thinktran/php:php8.4-frankenphp-opcache -f Dockerfile .
docker push thinktran/php:php8.4-frankenphp-opcache
