# Use the official Ubuntu 18.04 as the base image
FROM ubuntu:18.04

# Set non-interactive mode for APT
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei
ENV PHP_VERSION=7.2
ENV MYSQL_SERVER_VERSION=5.7

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get install -y \
    htop \
    jq \
    vim \
    curl \
    wget \
    telnet \
    php$PHP_VERSION-cli \
    php$PHP_VERSION-curl \
    php$PHP_VERSION-fpm \
    php$PHP_VERSION-ldap \
    php$PHP_VERSION-mysql \
    php$PHP_VERSION-zip \
    phpunit \
    mysql-server-$MYSQL_SERVER_VERSION \
    ssl-cert \
    nginx \
    openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22 80 443 8080 8443 3306

# Set up MySQL
RUN service mysql start && \
    mysql -e "CREATE USER 'developer'@'%' IDENTIFIED BY 'developer'; GRANT ALL PRIVILEGES ON *.* TO 'developer'@'%'; CREATE DATABASE developer; FLUSH PRIVILEGES;"

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
    mkdir -p /usr/share/phpmyadmin/tmp && \
    chown -R www-data:www-data /usr/share/phpmyadmin && \
    chmod 777 /usr/share/phpmyadmin/tmp

# Copy the entrypoint script
COPY nginx-php$PHP_VERSION-fpm-phpmyadmin.conf /etc/nginx/sites-enabled/phpmyadmin
COPY nginx-php$PHP_VERSION-fpm-website.conf /etc/nginx/sites-enabled/default 
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Start services in the foreground
CMD ["bash"]

