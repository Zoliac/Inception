DC_FILE=/srcs/docker-compose.yml
DC=docker compose -f $(DC_FILE)

all: pre up

pre:
	@mkdir -p /home/ameduboi/data

up:
	$(DC) up

down:
	$(DC) down

clean:

fclean:
	$(DC) down -v --rmi all

re:

.PHONY: all pre up down clean re fclean
