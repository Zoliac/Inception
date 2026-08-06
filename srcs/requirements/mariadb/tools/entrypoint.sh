#!/bin/sh
set -e
# si pas de volumes ni de data, on en met dedans
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # demarage tempo de maria pour mettre la data sql dedans
    mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking=0 &
    pid="$!"

    # On attend que ce process temporaire réponde
    until mariadb-admin ping --silent 2>/dev/null; do
        sleep 1
    done

    export MARIADB_PASSWORD=$(cat /run/secrets/db_password)
    export MARIADB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

    if [ -f "/tools/initdb.sql" ]; then
        envsubst < /tools/initdb.sql | mariadb -u root
    fi

    # arret de l'instance tempo
    mariadb-admin -u root shutdown
    wait "$pid"   # wait ok parce que on attend la fin de l'instance et pas la fin du programme pid1
    echo "Initialization done."
fi
exec mariadbd --user=mysql --datadir=/var/lib/mysql