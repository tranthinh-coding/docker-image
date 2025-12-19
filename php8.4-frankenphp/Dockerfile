# PHP 8.4 + FrankenPHP + MongoDB Base Image
# For Laravel Octane with FrankenPHP
# 
# Build: docker build -t thinktran/php:php8.4-frankenphp .
# Push:  docker push thinktran/php:php8.4-frankenphp

FROM dunglas/frankenphp:php8.4-alpine

LABEL maintainer="Think"
LABEL description="PHP 8.4 with FrankenPHP, MongoDB, Redis, Imagick"

ENV LANG=C.UTF-8
ENV TZ=Asia/Ho_Chi_Minh

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# --------------------------------------------------
# System & build dependencies
# --------------------------------------------------
RUN apk add --no-cache \
    $PHPIZE_DEPS \
    git curl zip unzip \
    libzip-dev \
    icu-dev \
    oniguruma-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libwebp-dev \
    postgresql-dev \
    openssl-dev \
    zlib-dev \
    cyrus-sasl-dev \
    imagemagick \
    imagemagick-dev \
    libtool \
    ghostscript \
    fontconfig \
    libpng

# --------------------------------------------------
# PHP extensions (core)
# --------------------------------------------------
RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
    && docker-php-ext-install -j$(nproc) \
        pdo \
        pdo_pgsql \
        pgsql \
        pdo_mysql \
        mysqli \
        zip \
        intl \
        mbstring \
        bcmath \
        pcntl \
        gd \
        exif

# --------------------------------------------------
# PECL extensions
# --------------------------------------------------
RUN pecl install \
    https://pecl.php.net/get/mongodb-2.1.4.tgz \
    https://pecl.php.net/get/redis-6.3.0.tgz \
    https://pecl.php.net/get/imagick-3.8.0.tgz \
    && docker-php-ext-enable mongodb redis imagick

# --------------------------------------------------
# Cleanup build deps
# --------------------------------------------------
RUN apk del $PHPIZE_DEPS \
    && rm -rf /tmp/* /var/cache/apk/*

# --------------------------------------------------
# Composer
# --------------------------------------------------
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# --------------------------------------------------
# PHP settings
# --------------------------------------------------
RUN echo "upload_max_filesize=100M" > /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size=100M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "memory_limit=512M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "max_execution_time=300" >> /usr/local/etc/php/conf.d/uploads.ini

CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
