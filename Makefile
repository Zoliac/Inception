DC_FILE=srcs/docker-compose.yml
DC=docker compose -f $(DC_FILE)

DOMAIN= lpatin.42.fr

VOL_PATH= /home/lpatin/data

all: pre up

pre:
	@mkdir -p $(VOL_PATH)
	@if [ ! -f /etc/docker/daemon.json ]; then \
		echo "{\n\"data-root\": \"$(VOL_PATH)/docker\"\n}" | sudo tee /etc/docker/daemon.json > /dev/null; \
		sudo systemctl restart docker; \
	fi
	@line="127.0.0.1 ${DOMAIN}"; \
	if ! grep -qF "$$line" /etc/hosts; then \
		echo "$$line" | sudo tee -a /etc/hosts > /dev/null; \
	fi

up:
	$(DC) up

down:
	$(DC) down

clean:
	$(DC) down

fclean:
	$(DC) down -v --rmi all

re:
	$(MAKE) fclean
	$(MAKE) all

.PHONY: all pre up down clean re fclean

EXPOSE 443
