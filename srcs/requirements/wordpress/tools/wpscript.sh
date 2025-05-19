#!/bin/bash
#set -eux

#cd /var/www/html/wordpress

if ! [ -f "wp-config.php" ];then
	wp config create --allow-root --dbname=${SQL_DATABASE} \
		--dbuser=${SQL_USER} \
		--dbpass=${SQL_PASSWORD} \
		--dbhost=${SQL_HOST} \
		--url=https://${DOMAIN_NAME};

	wp core install --url=https://${DOMAIN_NAME} \
		--title=${SITE_TITLE} \
		--admin_user=${ADMIN_PASSWORD} \
		--admin_password=${ADMIN_PASSWORD} \
		--admin_email=${ADMIN_EMAIL} \
		--allow-root;

	wp user create ${USER1_LOGIN} ${USER1_MAIL} \
		--role=author \
		--user_pass=${USER1_PASS} \
		--allow-root;

	wp cache flush --allow-root

	# interface to create custom contact forms, manage submissions, anti-spam
	wp plugin install contact-form-7 --activate

	wp language core install en_US --activate

	#removes default themes and plugins
	wp theme delete twentynineteen twentytwenty
	wp plugin delete hello

	#set the permalink struct
	wp rewrite structure '/%postname%/'

fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

# starts the PHP FastCGI Process Manager (FPM) in the foreground
exec /usr/sbin/php-fpm7.4 -F -R
