FROM bullseye:oldstable

COPY . .

WORKDIR /

RUN apk update --no-cache \
    && apk add --no-cache mariadb mariadb-client gettext-envsubst \
    && mkdir -p /var/lib/mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld \
    && mariadb-install-db --user=mysql --datadir=/var/lib/mysql

COPY conf/my.conf /etc/grafana/.my.cnf
COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh 

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
