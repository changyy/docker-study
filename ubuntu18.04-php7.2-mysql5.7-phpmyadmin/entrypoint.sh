#!/bin/bash
# Start MySQL service
service mysql start

# Start PHP-FPM service
service php7.2-fpm start

service ssh start
service nginx start

date

# Keep the container running
tail -f /dev/null

