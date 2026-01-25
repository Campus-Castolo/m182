.PHONY: init up down logs ps test

init:
	./scripts/init.sh

up:
	docker compose up -d --build

down:
	docker compose down -v

ps:
	docker compose ps

logs:
	docker compose logs -f --tail=200

test:
	docker compose exec client sh -lc "/client/run-tests.sh"
