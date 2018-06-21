all: start

start:
	docker-compose up -d

stop:
	docker-compose down --remove-orphans

status:
	docker-compose ps

reload:
	docker-compose exec nginx nginx -s reload
