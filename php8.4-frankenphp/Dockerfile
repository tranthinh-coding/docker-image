# PHP 8.4 + FrankenPHP + MongoDB Base Image
# For Laravel Octane with FrankenPHP
# 
# Build: docker build -t thinktran/php:php8.4-frankenphp .
# Push:  docker push thinktran/php:php8.4-frankenphp

FROM dunglas/frankenphp:php8.4-alpine

LABEL maintainer="Think"
LABEL description="PHP 8.4 with FrankenPHP, MongoDB, and common Laravel extensions"

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG=C.UTF-8

# set default time zone for server
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apk add --no-cache \
    # Build dependencies
    $PHPIZE_DEPS \
    # Common dependencies
    git \
    curl \
    zip \
    unzip \
    libzip-dev \
    icu-dev \
    oniguruma-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libwebp-dev \
    # PostgreSQL
    postgresql-dev \
    # MongoDB dependencies
    openssl-dev \
    # Redis dependencies (if using phpredis)
    # ImageMagick (optional)
    imagemagick-dev \
    imagemagick \
    # For bcmath
    # For intl
    # For gd
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
    # Install PHP extensions
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
        exif \
    # Install MongoDB extension via PECL
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    # Install Redis extension (phpredis release/6.3.0 – pinned)
    && git clone --branch release/6.3.0 --depth=1 https://github.com/phpredis/phpredis.git /tmp/phpredis \
    && cd /tmp/phpredis \
    && phpize \
    && ./configure \
    && make -j$(nproc) \
    && make install \
    && docker-php-ext-enable redis \
    && rm -rf /tmp/phpredis \
    # Install Imagick extension via PECL
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    # Cleanup
    && apk del $PHPIZE_DEPS \
    && rm -rf /tmp/* /var/cache/apk/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# PHP upload limits configuration
RUN echo "upload_max_filesize=100M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size=100M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "memory_limit=512M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "max_execution_time=300" >> /usr/local/etc/php/conf.d/uploads.ini

# Default command (can be overridden)
CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
