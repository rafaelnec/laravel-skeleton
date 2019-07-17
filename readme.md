# Docker with Laravel + Nginx + MariaDB + NPM

This is a skeleton of the Laravel 5.8 + Nginx + MariaDB with Docker.

## Requirements: 

	- Docker [Link](https://docs.docker.com/install/)

## Configuration Files:

### [Php-fpm]

	- Config: [php-fpm.conf](deploy/php-fpm/conf.d/laravel-skeleton.conf)

### [Php]

	- Config: [php.ini](deploy/php/conf.d/local.ini)

### [Nginx] 

	- Config Vhost: [app.conf](deploy/nginx/sites-available/app)

### [Mysql]

	- Config: [my.cnf](deploy/mysql/my.cnf)
	- Enviroment: [.env](deploy/mysql/.env)

### [Laravel]

	- Config: [.env](.env)

## Run

	- Go to: /path/laravel-skeleton
	- docker-compose up -d

## Acess Laravel:

	Inside the container the Laravel is running with the port 80.
	For development this project run with Docker-Compose in the ports 9000 and 3000.
	The port 3000 run the Npm run watch every change in your code is reflected without refresh the browser.

	- [http://localhost:9000](http://localhost:9000) To access Laravel
	- [http://localhost:3000](http://localhost:3000) To access Laravel with npm run watch


## Commands:

	- Get container id: `docker ps`
	- Logs: `docker log *<id_container>* -f`
	- Remove all containers and volumes: 
	```
	// This command remove all container and volumes of your computer
	docker-compose down && docker system prune -a -f && docker volume prune -f
	```



