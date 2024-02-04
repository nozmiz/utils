FROM nginx:1.23.1

RUN apt update && apt install -y curl vim procps iproute2 net-tools dnsutils iputils-ping netcat jq
ADD ./src/nginx.conf /etc/nginx/nginx.conf
ADD ./src/server.crt /etc/nginx/ssl/server.crt
ADD ./src/server.key /etc/nginx/ssl/server.key
