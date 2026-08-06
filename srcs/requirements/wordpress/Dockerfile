FROM alpine:3.23.5
# au final on va utiliser alpine mdr, bullseye je comprends moins

# installer php
RUN apk update && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-mbstring \
    php82-openssl \
    php82-xml \
    php82-zip \
    wget \
    curl \
    mariadb-client

# faire un user sans que les donnees soient decouvertes
RUN if ! getent group www-data > /dev/null 2>&1; then \
        addgroup -S www-data; \
    fi && \
    if ! getent passwd www-data > /dev/null 2>&1; then \
        adduser -S -G www-data www-data; \
    fi

# faire le dossier pour wordpress
RUN mkdir -p /var/www/wordpress

# dl toutes les dependences de wordpress
WORKDIR /var/www/wordpress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz && \
    chown -R www-data:www-data /var/www/wordpress

# config PHP-FPM
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/user = nobody/user = www-data/' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = www-data/' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's/;clear_env = no/clear_env = no/' /etc/php82/php-fpm.d/www.conf

# permissions des fichiers
RUN chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress && \
    chmod 777 /var/www/wordpress/wp-content

# on expose 9000 pour php-fpm
EXPOSE 9000

#on copie et on lance l'entrypoint
COPY tools/entrypoint.sh /tools/entrypoint.sh
RUN chmod +x /tools/entrypoint.sh
ENTRYPOINT ["/tools/entrypoint.sh"]

# la on lance php avec le user www-data comme ca le container ne s'eteint pas
CMD ["php-fpm82", "-F"]