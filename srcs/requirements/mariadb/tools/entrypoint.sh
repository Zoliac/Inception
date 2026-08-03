set -e

/usr/bin/mariadbd-safe --datadir=/var/lib/mysql &

echo "Waiting for MariaDB to be ready..."
until mariadb-admin ping --silent; do
	sleep 2
done
echo "MariaDB is ready"

export MARIADB_PASSWORD=$(cat /run/secrets/db_password)
export MARIADB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

if [ -f "/tools/initdb.sql" ]; then
	envsubst < /tools/initdb.sql | mariadb
	
fi
echo "MariaDB is ready"
wait
