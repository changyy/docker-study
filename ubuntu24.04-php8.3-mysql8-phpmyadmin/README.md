# Usage

```
% docker build -t ubuntu24.04-php8.3-mysql8.0-phpmyadmin . 
```

```
% docker run -it -p 20022:22 -p 80:80 -p 8080:8080 -p 443:443 ubuntu24.04-php8.3-mysql8.0-phpmyadmin
```

```
% docker run -it -p 20022:22 -p 80:80 -p 8080:8080 -p 443:443 ubuntu24.04-php8.3-mysql8.0-phpmyadmin /bin/bash
# service ssh start ; service mysql start ; service php8.3-fpm start ; service nginx start 
```

## Account

- developer:12345678

# Options

Using local directory as volume

```
% wget https://getcomposer.org/download/latest-stable/composer.phar -O /tmp/composer.phar
% php -v
PHP 8.2.20 (cli) (built: Jun 13 2024 20:39:57) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.2.20, Copyright (c) Zend Technologies
% php /tmp/composer.phar self-update
You are already using the latest available Composer version 2.7.7 (stable channel).
% php /tmp/composer.phar create-project --prefer-dist laravel/laravel /tmp/my-laravel-workspace
% cd /tmp/my-laravel-workspace
% php artisan serve

   INFO  Server running on [http://127.0.0.1:8000].  

  Press Ctrl+C to stop the server
```

```
% docker run -it -p 20022:22 -p 80:80 -p 8080:8080 -p 443:443 -v /tmp/my-laravel-workspace:/var/www/laravel ubuntu24.04-php8.3-mysql8.0-phpmyadmin
```
