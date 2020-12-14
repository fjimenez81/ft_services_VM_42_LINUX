FROM alpine:latest

#datasource.yaml dashboard.yaml dashboards

COPY datasource.yaml dashboard.yaml telegraf.conf setup.sh ./

RUN chmod +x setup.sh

# Install Grafana
RUN apk update && \
	apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community grafana

# Configure Grafana
RUN mv datasource.yaml /usr/share/grafana/conf/provisioning/datasources/ && \
	mv dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/

#Database Grafana
ADD grafana.db /usr/share/grafana/data/grafana.db

# Install telegraf
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 3000

CMD ./setup.sh
