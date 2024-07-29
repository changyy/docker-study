# Use the official Ubuntu 18.04 as the base image
FROM ubuntu:24.04

# Set non-interactive mode for APT
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei
ENV PHP_VERSION=8.3
ENV MYSQL_SERVER_VERSION=8.0

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get install -y \
    htop \
    git \
    tree \
    jq \
    vim \
    curl \
    wget \
    telnet \
    sockstat \
    php$PHP_VERSION-cli \
    php$PHP_VERSION-curl \
    php$PHP_VERSION-mcrypt \ 
    php$PHP_VERSION-intl \
    php$PHP_VERSION-sqlite3 \
    php$PHP_VERSION-fpm \
    php$PHP_VERSION-ldap \
    php$PHP_VERSION-mysql \
    php$PHP_VERSION-zip \
    7zip \
    unzip \
    phpunit \
    ssl-cert \
    composer \
    nginx \
    mysql-server-$MYSQL_SERVER_VERSION \
    openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22 80 443 8080 8443 3306

# SSH Tunnel Usage
RUN useradd -m developer && echo "developer:12345678" | chpasswd

# MySQL Server Configuration
RUN service mysql start && \
    mysql -e "CREATE USER 'developer'@'%' IDENTIFIED BY '12345678'; GRANT ALL PRIVILEGES ON *.* TO 'developer'@'%'; CREATE DATABASE developer; FLUSH PRIVILEGES;"

# Set up PHP-FPM Short Open Tag
RUN test -f /etc/php/$PHP_VERSION/fpm/php.ini && \ 
    #sed -i 's/short_open_tag = Off/short_open_tag = On/' /etc/php/$PHP_VERSION/fpm/php.ini && \
    sed -i 's/max_execution_time = 30/max_execution_time = 300/' /etc/php/$PHP_VERSION/fpm/php.ini && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/' /etc/php/$PHP_VERSION/fpm/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 100M/' /etc/php/$PHP_VERSION/fpm/php.ini 

# Set up phpmyadmin
RUN cd /tmp && \
    wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz && \
    tar xvzf phpMyAdmin-latest-all-languages.tar.gz && \
    mv phpMyAdmin-*-all-languages /usr/share/phpmyadmin && \
    cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php && \
    sed -i "s/\$cfg\['Servers'\]\[\$i\]\['host'\] = 'localhost';/\$cfg\['Servers'\]\[\$i\]\['host'\] = '127.0.0.1';/" /usr/share/phpmyadmin/config.inc.php && \
    mkdir -p /usr/share/phpmyadmin/tmp && \
    chown -R www-data:www-data /usr/share/phpmyadmin && \
    chmod 777 /usr/share/phpmyadmin/tmp

# Set up a laravel project
RUN composer create-project --prefer-dist laravel/laravel /var/www/laravel && \
    php /var/www/laravel/artisan key:generate && \
    chown -R www-data:www-data /var/www/laravel && \
    chmod 777 /var/www/laravel/storage

COPY nginx-php$PHP_VERSION-fpm-phpmyadmin.conf /etc/nginx/sites-enabled/phpmyadmin
COPY nginx-php$PHP_VERSION-fpm-laravel.conf /etc/nginx/sites-enabled/default 

CMD service ssh start && service mysql start && service php$PHP_VERSION-fpm start && service nginx start && tail -f /var/log/nginx/access.log /var/log/nginx/error.log;
