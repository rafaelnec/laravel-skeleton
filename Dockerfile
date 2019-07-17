#PHP Image Docker
FROM php:7.3-fpm

# Set working directory
WORKDIR /laravel-skeleton

# Copy existing application directory contents
COPY . /laravel-skeleton

#Add Npm apt source
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Install dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-client locales nginx zip unzip libzip-dev nodejs
RUN docker-php-ext-configure zip --with-libzip 
RUN docker-php-ext-install -j$(nproc) mysqli pdo_mysql zip
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#Configure DateTime
RUN ln -fs /usr/share/zoneinfo/America/Vancouver /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata
RUN sed -i -e 's/# en_CA.UTF-8 UTF-8/en_CA.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_CA.UTF-8  
ENV LANGUAGE en_CA:en  
ENV LC_ALL en_CA.UTF-8 

#Install composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --no-interaction -o
RUN composer dump-autoload

#Npm install
RUN npm install

# PHP
RUN rm -Rf /usr/local/etc/php-fpm.d/*
RUN mkdir -p /var/log/php/ && touch /var/log/php/fpm-php.qcon-web.log && chmod 777 /var/log/php/fpm-php.qcon-web.log
COPY ./deploy/php-fpm/conf.d/ /usr/local/etc/php-fpm.d/
COPY ./deploy/php/conf.d/ /etc/php7/conf.d/
COPY ./deploy/php/conf.d/ /usr/local/etc/php/conf.d/

# NGINX
COPY ./deploy/nginx/sites-available/ /etc/nginx/sites-available/
RUN rm -Rf /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/app
RUN service nginx start

# Expose port 80 and start php-fpm server
EXPOSE 80
EXPOSE 3000

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]