FROM bullseye:oldstable

COPY . .

WORKDIR /

RUN apt update && apt install -y curl mariadb

COPY conf/my.conf /etc/grafana/.my.cnf
COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh 

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
