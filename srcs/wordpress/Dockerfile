FROM alpine:latest

COPY wp-config.php telegraf.conf setup.sh ./

RUN chmod +x setup.sh

# Install PHP
RUN apk update && \
	apk upgrade && \
	apk add --no-cache php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session

# Download Wordpress
#ADD https://wordpress.org/latest.tar.gz .
COPY wordpress-5.5.3.tar.gz .

# Install Wordpress
RUN tar -xvf wordpress-5.5.3.tar.gz && \
	mv wordpress /www && \
	mv wp-config.php /www/ && \
	rm -f wordpress-5.5.3.tar.gz

# Install telegraf
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 5050

CMD ./setup.sh
