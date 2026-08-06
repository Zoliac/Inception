FROM alpine:3.23.5
# au final on va utiliser alpine mdr, bullseye je comprends moins
 
#installer toutes les dependences dont on a besoin, ssl, nginx
RUN apk update --no-cache \
&& apk add --no-cache nginx openssl \
&& mkdir -p /etc/nginx/ssl /var/run/nginx /var/www/wordpress \
&& rm /etc/nginx/http.d/default.conf \
&& openssl req -x509 -nodes \
	-days 365 \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/lpatin.42.fr.key \
	-out /etc/nginx/ssl/lpatin.42.fr.fullchain.crt -subj "/C=FR/L=LeHavre/O=42/OU=student/CN=lpatin.42.fr"
 
# copier le fichier .conf dans le container
COPY conf/nginx.conf /etc/nginx/http.d/nginx.conf
 
# lancer nginx au demarage.
CMD [ "nginx", "-g", "daemon off;" ]
