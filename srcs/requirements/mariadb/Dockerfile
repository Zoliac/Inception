FROM alpine:3.21.2
# au final on va utiliser alpine mdr, bullseye je comprends moins

RUN apk update --no-cache \
&& apk add --no-cache mariadb mariadb-client gettext-envsubst \
&& mkdir -p /var/lib/mysql /run/mysqld \
&& chown -R mysql:mysql /var/lib/mysql /run/mysqld \
&& mariadb-install-db --user=mysql --datadir=/var/lib/mysql

COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb.cnf
COPY tools/initdb.sql /tools/initdb.sql
COPY tools/entrypoint.sh /tools/entrypoint.sh
RUN chmod +x /tools/entrypoint.sh

USER mysql

ENTRYPOINT ["/tools/entrypoint.sh"]
