FROM alpine:3.21.2
# au final on va utiliser alpine mdr, bullseye je comprends moins

#installer toutes les dependences dont on a besoin, ssl, nginx
RUN apk update --no-cache \
&& apk add --no-cache nginx openssl \
&& mkdir -p /etc/nginx/ssl /var/run/nginx /var/www/wordpress \
&& rm /etc/nginx/http.d/default.conf \
&& openssl req -x509 -nodes \
	-days 365 \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/L=LeHavre/O=42/OU=student/CN=lpatin.42.fr" \
&& sed -i 's/^\(\s*\)ssl_protocols\s\+.*/\1ssl_protocols TLSv1.2 TLSv1.3;/' /etc/nginx/nginx.conf

# copier le fichier .conf dans le container

COPY conf/nginx.conf /etc/nginx/http.d/nginx.conf

# lancer nginx au demarage.

CMD [ "nginx", "-g", "daemon off;" ]