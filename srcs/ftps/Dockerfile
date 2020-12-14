FROM alpine:latest

COPY vsftpd.conf telegraf.conf setup.sh ./

RUN chmod +x setup.sh

# Install vsftpd and dependencies
RUN apk update && \
	apk upgrade && \
	apk add --no-cache vsftpd openssl

# Create user
RUN mkdir -p /etc/ftps/ferfox && \
	adduser --home=/etc/ftps/ferfox -D ferfox && \
	echo "ferfox:hola" | chpasswd

# Setup vsftpd
RUN mv vsftpd.conf /etc/vsftpd/ && \
	echo "ferfox" >> /etc/vsftpd/vsftpd.userlist

# Setup SSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj '/CN=127.0.0.1'

# Install telegraf
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 20 21 21009-21011

CMD ./setup.sh

