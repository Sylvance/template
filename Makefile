all: create migrate seed run

.PHONY: cluster
cluster:
	./bin/kind-create-cluster-with-registry.sh

.PHONY: delete-cluster
delete-cluster:
	kind delete cluster

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

.PHONY: dev
dev:
	SSH_PRIVATE_KEY=`cat ~/.ssh/id_rsa` skaffold dev --no-prune=false --cache-artifacts=false
