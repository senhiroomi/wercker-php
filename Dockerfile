FROM php:7.1.4-cli

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
	libbz2-dev \
	openssl libssl-dev \
	libicu-dev \
	curl \
	git \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

#Download dependencies

# Set memory limit
RUN echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Set environmental variables
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
    pcntl \
    sockets \
    zip \
    pdo_mysql \
    opcache \
    tokenizer \
    mcrypt \
    intl

CMD ["php"]

FROM node:6.9.5-slim
CMD ["npm"]
