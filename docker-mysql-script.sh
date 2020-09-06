#!/usr/bin/env bash
TIMESTAMP=$(date +%Y%b%d-%H-%M-%S)
BACKUP_DIR="/mnt/dailymysqldb/$TIMESTAMP"
MYSQL_USER=root
MYSQL_PASSWORD=$MYSQL_ROOT_PASSWORD
mkdir -p $BACKUP_DIR
databases=$(mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|mysql|sys|performance_schema)")
for db in $databases; do
    mysqldump --user=$MYSQL_USER -p$MYSQL_PASSWORD --skip-lock-tables --quick --single-transaction --databases $db | gzip >"$BACKUP_DIR/$db.gz"
done


# command execution from docker machine
docker exec node_mysql_1 sh -c "bash jino.sh"
