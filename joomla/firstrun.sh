# Inspired by https://github.com/alex7r/joomla-ssh-installation-vagrant/blob/master/setup_joomla.sh

#JUSERID=$[ ( $RANDOM % 100 )  + 1 ]

JUSERID=11
JUSERNAME="joomla"
JUSEREMAIL="joomla@localhost.com"
JUSERPASS="1234"

DB="joomla"
DBUSER="jdbuser"
DBPASS="dbupass"
DBPREFIX="project_"
LIVE_SITE="http:\/\/joomla.local" # escaped per evitare errori
JOOMLA_DB_HOST="db"
MYSQL_ROOT_PASSWORD="secret"

# Controllo se la configurazione è già stata fatta
test -f configuration.php && exit
echo "Running firstrun..."

# Unzip Joomla
echo "Unzipping Joomla..."
unzip -q /var/tmp/Joomla_$JOOMLA_VERSION-Stable-Full_Package.zip -d /var/www/html

# Set permissions
chown -R www-data:www-data /var/www/html
chown -R www-data:www-data /var/www/tmp
chown -R www-data:www-data /var/www/logs

# Configure Joomla
sed -i "s/\$user = ''/\$user = '${DBUSER}'/" installation/configuration.php-dist
sed -i "s/\$host = 'localhost'/\$host = '${JOOMLA_DB_HOST}'/" installation/configuration.php-dist
sed -i "s/\$password = ''/\$password = '${DBPASS}'/" installation/configuration.php-dist
sed -i "s/\$db = ''/\$db = '${DB}'/" installation/configuration.php-dist
sed -i "s/\$dbprefix = 'jos_'/\$dbprefix = '${DBPREFIX}'/" installation/configuration.php-dist
sed -i "s/\$tmp_path = '\/tmp'/\$tmp_path = '\/var\/www\/tmp'/" installation/configuration.php-dist
sed -i "s/\$log_path = '\/var\/logs'/\$log_path = '\/var\/www\/logs'/" installation/configuration.php-dist
sed -i "s/\$cache_handler = 'file'/\$cache_handler = ''/" installation/configuration.php-dist
sed -i "s/\$live_site = ''/\$live_site = '${LIVE_SITE}'/" installation/configuration.php-dist
mv installation/configuration.php-dist configuration.php
echo "Configured configuration.php"


# Create Joomla db user
echo "CREATE DATABASE IF NOT EXISTS ${DB}" | mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $JOOMLA_DB_HOST
echo "CREATE USER '${DBUSER}'@'%' IDENTIFIED BY '${DBPASS}';" | mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $JOOMLA_DB_HOST
echo "GRANT ALL ON ${DB}.* TO '${DBUSER}'@'%';" | mysql -u root --password=$MYSQL_ROOT_PASSWORD -h $JOOMLA_DB_HOST
sed -i "s/#__/${DBPREFIX}/" installation/sql/mysql/joomla.sql
cat installation/sql/mysql/joomla.sql | mysql -u $DBUSER --password=$DBPASS -h $JOOMLA_DB_HOST $DB
echo "Created Joomla db user"

# Create Joomla user
JPASS="$(echo -n "$JUSERPASS" | md5sum | awk '{ print $1 }' )"
echo "Hashed password = ${JPASS}"
echo "INSERT INTO \`${DBPREFIX}users\` (\`id\`, \`name\`, \`username\`, \`email\`, \`password\`, \`block\`, \`sendEmail\`, \`registerDate\`, \`lastvisitDate\`, \`activation\`, \`params\`, \`lastResetTime\`, \`resetCount\`, \`otpKey\`, \`otep\`, \`requireReset\`) VALUES ('${JUSERID}', 'Me', '${JUSERNAME}', '${JUSEREMAIL}', '${JPASS}', '0', '0', '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', '', '', '0000-00-00 00:00:00.000000', '0', '', '', '0');" | mysql -u $DBUSER --password=$DBPASS -h $JOOMLA_DB_HOST $DB
echo "INSERT INTO \`${DBPREFIX}user_usergroup_map\` (\`user_id\`, \`group_id\`) VALUES ('${JUSERID}', '8');" | mysql -u $DBUSER --password=$DBPASS -h $JOOMLA_DB_HOST $DB
JUSERINC=$((JUSERID+1))
echo "ALTER TABLE \`${DBPREFIX}users\` auto_increment = ${JUSERINC};" | mysql -u $DBUSER --password=$DBPASS -h $JOOMLA_DB_HOST $DB
echo "Created Joomla user"

rm -rf installation/
