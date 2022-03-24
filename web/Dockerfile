FROM nginxinc/nginx-unprivileged:mainline-alpine

USER root

# Remove default configuration and add our custom Nginx configuration files
RUN rm /etc/nginx/conf.d/default.conf \
    && apk add --no-cache curl

COPY ["./mattermost", "./mattermost-ssl", "/etc/nginx/sites-available/"]

RUN apk update && apk add openssl
#
#RUN openssl dhparam -out /etc/nginx/conf.d/dhparam.pem 2048 &&\
#    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/conf.d/self.key -out /etc/nginx/conf.d/self.crt \
#    -subj "/C=RU/ST=Cheboxary/L=ch/O=ch/OU=Org/CN=mattermost-certificate"

RUN openssl req -x509 -nodes -days 365 -subj "/C=RU/ST=ch/O=ch, Inc./CN=mattermost" -addext "subjectAltName=DNS:mattermost" -newkey rsa:2048 -keyout /etc/nginx/conf.d/nginx-selfsigned.key -out /etc/nginx/conf.d/nginx-selfsigned.crt;

#COPY ./cert.crt /etc/nginx/conf.d/
#COPY ./key.crt /etc/nginx/conf.d/
#COPY ./passw.pass /etc/nginx/conf.d/

# Add and setup entrypoint
COPY entrypoint.sh /

RUN chown -R nginx:nginx /etc/nginx/sites-available && \
         chown -R nginx:nginx /var/cache/nginx && \
         chown -R nginx:nginx /var/log/nginx && \
         chown -R nginx:nginx /etc/nginx/conf.d && \
         chown nginx:nginx entrypoint.sh
RUN touch /var/run/nginx.pid && \
         chown -R nginx:nginx /var/run/nginx.pid

COPY ./security.conf /etc/nginx/conf.d/

RUN chown -R nginx:nginx /etc/nginx/conf.d/security.conf

RUN chmod u+x /entrypoint.sh

RUN sed -i "/^http {/a \    proxy_buffering off;\n" /etc/nginx/nginx.conf
RUN sed -i '/temp_path/d' /etc/nginx/nginx.conf \
    && sed -i 's!/tmp/nginx.pid!/var/run/nginx.pid!g' /etc/nginx/nginx.conf

USER nginx

#Healthcheck to make sure container is ready
HEALTHCHECK CMD curl --fail http://localhost:8080 || exit 1

ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/var/run", "/etc/nginx/conf.d/", "/var/cache/nginx/"]
