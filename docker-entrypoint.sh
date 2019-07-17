#!/bin/sh

#Check if Database is ready...
while ! mysql -hdb -uls -p'l@r@v&l' -e "show databases;" > /dev/null 2>&1; do
    >&2 echo "Waiting mysql is running to execute restore..."
    sleep 3
done

#Update database laravel
>&2 echo "Update database..."
php artisan migrate:install -n -q > /dev/null
php artisan migrate --force -n -q > /dev/null
php artisan db:seed -n -q > /dev/null

#Configurate laravel
>&2 echo "Configurate laravel..."
php artisan key:generate  -n -q > /dev/null
php artisan config:cache  -n -q > /dev/null
php artisan route:cache  -n -q > /dev/null

#Permissions
>&2 echo "Set Permissions..."
chmod -Rf 777 /laravel-skeleton/storage/logs/ /laravel-skeleton/storage/framework/sessions/ /laravel-skeleton/storage/framework/views/ > /dev/null

#Start FPM
>&2 echo "Starting php-fpm..."
php-fpm -D > /dev/null

#Start NGINX
>&2 echo "Starting nginx..."
nginx -g 'daemon on;' > /dev/null

#Start npm watch development enviroment
>&2 echo "Starting npm run..."
npm run watch