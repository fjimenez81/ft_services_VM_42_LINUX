FROM alpine:latest

COPY telegraf.conf setup.sh ./

RUN chmod +x setup.sh

# Install influxdb and dependencies
RUN apk update && \
	apk add --no-cache influxdb

# Install telegraf
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 8086

CMD ./setup.sh
