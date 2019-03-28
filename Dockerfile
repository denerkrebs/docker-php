FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install -y nginx php7.0-fpm supervisor && \
    rm -rf /var/lib/apt/lists/*

#Define the ENV variable
ENV nginx_vhost /etc/nginx/sites-available/default
ENV php_conf /etc/php
ENV nginx_conf /etc/nginx/nginx.conf
ENV supervisor_conf /etc/supervisor/supervisord.conf

COPY etc/php ${php_conf}
 
# Enable php-fpm on nginx virtualhost configuration
COPY etc/nginx/nginx.conf ${nginx_vhost}
# RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_conf} && \
#     echo "\ndaemon off;" >> ${nginx_conf}

#Copy supervisor configuration
COPY etc/supervisord.conf ${supervisor_conf}

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /var/www/html && \
    chown -R www-data:www-data /run/php

# Volume configuration
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Configure Services and Port
COPY etc/start.sh /start.sh
CMD ["./start.sh"]
 
EXPOSE 80 443