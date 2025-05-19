FROM debian:bullseye


RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y wget
RUN apt-get install -y php7.4 php-fpm php-mysql

#a cmd-line interface for WP, you can manage WP once it's dl
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN apt-get update && apt-get install -y default-mysql-client
RUN apt-get install -y mariadb-client
RUN wget https://wordpress.org/wordpress-6.4.2.tar.gz -P /var/www/html
RUN cd /var/www/html && tar -xzf /var/www/html/wordpress-6.4.2.tar.gz && rm /var/www/html/wordpress-6.4.2.tar.gz

#ensure that the web serv (nginx) has the perms to read and execute files in web root dir
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

EXPOSE 9000

COPY ./tools/wpscript.sh /
RUN chmod +x ./wpscript.sh

COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www/html/wordpress

ENTRYPOINT ["bash", "/wpscript.sh"]
