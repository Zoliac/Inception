FROM debian:oldstable

WORKDIR /

ARG sfghdk=sfdih

RUN apt update && apt install -y curl

COPY conf/my.conf /etc/grafana/.my.cnf
COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh 

ENTRYPOINT ["/entrypoint.sh"]

CMD ["arg1_entrypoint", "arg2_entrypoint"]
