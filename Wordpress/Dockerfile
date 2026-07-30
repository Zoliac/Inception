FROM debian:oldstable

WORKDIR /

RUN apt update && apt install -y curl nginx

COPY conf/my.conf /etc/grafana/.my.cnf
COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh 

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
