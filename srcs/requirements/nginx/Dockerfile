FROM bullseye:oldstable

COPY . .

WORKDIR /

RUN apt update && apt install -y curl nginx

COPY conf/my.conf /etc/grafana/.my.cnf
COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh 

ENTRYPOINT ["./tools/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
