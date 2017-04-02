#buddhikajay/nginx-files
FROM debian:jessie

MAINTAINER Buddhika Jayawardhana <buddhika.anushka@gmail.com>

RUN apt-get update && apt-get install -y \
    nginx

ADD nginx.conf /etc/nginx/
ADD files.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/files.conf /etc/nginx/sites-enabled/files
RUN rm /etc/nginx/sites-available/default
RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server file-manager:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
