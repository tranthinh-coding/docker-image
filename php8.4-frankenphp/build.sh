#!/bin/bash
export APP_ENV="production"
docker image rm thinktran/php:php8.4-frankenphp -f
docker build -t thinktran/php:php8.4-frankenphp -f Dockerfile .
docker push thinktran/php:php8.4-frankenphp
