.PHONY: dev
dev: 
	SSH_PRIVATE_KEY=`cat ~/.ssh/id_rsa` skaffold dev --no-prune=false --cache-artifacts=false

.PHONY: cluster
cluster:
	./bin/kind-create-cluster-with-registry.sh

.PHONY: deletecluster
deletecluster:
	kind delete cluster

.PHONY: getpods
getpods:
	kubectl get pods

.PHONY: appshell
appshell:
	echo "Attempting to enter the shell ..."
	kubectl exec -it $(pod) -- /bin/bash

.PHONY: dbshell
dbshell:
	kubectl exec -it $(pod) -- psql -h localhost -U postgres --password -p 5432 db

.PHONY: dbcreate
dbcreate:
	kubectl exec -it $(pod) -- rake db:create

.PHONY: dbseed
dbseed:
	kubectl exec -it $(pod) -- rake db:seed

.PHONY: dbmigrate
dbmigrate:
	kubectl exec -it $(pod) -- rake db:migrate
