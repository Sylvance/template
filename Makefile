all: create migrate seed run

.PHONY: create
create:
	rake db:create

.PHONY: migrate
migrate:
	rake db:migrate

.PHONY: seed
seed:
	rake db:seed

.PHONY: run
run:
	rails s
