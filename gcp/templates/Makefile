SHELL := /bin/bash
all: plan

init:
	terraform init

validate: init
	terraform validate

plan: validate init
	terraform plan | tee output

show:
	terraform show output

.PHONY: all validate plan

# Create resource

name-required:
	if [ -z ${NAME} ]; then echo 'NAME env is required.' && exit 1; fi

# NAME=prod-oolong make gke mysql redis
gce: name-required
	cat ../templates/compute_instance.tf >> compute_instance.tf
	sed -i '' -e  "s!its-test!$${NAME}!g" *.tf

gke: name-required
	cat ../templates/container_cluster.tf >> container_cluster.tf
	cat ../templates/container_node_pool.tf >> container_node_pool.tf
	sed -i '' -e  "s!its-test!$${NAME}!g" *.tf

mysql: name-required
	cat ../templates/mysql_sql_database_instance.tf >> sql_database_instance.tf
	cat ../templates/mysql_sql_database.tf >> mysql_sql_database.tf
	sed -i '' -e  "s!its-test!$${NAME}!g" *.tf
	sed -i '' -e  "s!test_database!chechia_$${NAME##*-}!g" mysql_sql_database.tf
	sed -i '' -e  "s!test_username!pro$${NAME##*-}!g" mysql_sql_database.tf

postgresql: name-required
	cat ../templates/postgresql_sql_database_instance.tf >> sql_database_instance.tf
	cat ../templates/postgresql_sql_database.tf >> postgresql_sql_database.tf
	sed -i '' -e  "s!its-test!$${NAME}!g" *.tf
	sed -i '' -e  "s!test_database!chechia_$${NAME##*-}!g" postgresql_sql_database.tf
	sed -i '' -e  "s!test_username!pro$${NAME##*-}!g" postgresql_sql_database.tf

redis: name-required
	cat ../templates/redis_instance.tf >> redis_instance.tf
	sed -i '' -e  "s!its-test!$${NAME}!g" *.tf

# WIP
#gcs:
#	cat ../templates/storage_bucket.tf >> storage_bucket.tf
#	cat ../templates/storage_bucket_acl.tf >> storage_bucket_acl.tf
#	cat ../templates/storage_bucket_iam_binding.tf >> storage_bucket_iam_binding.tf
#	cat ../templates/storage_bucket_iam_policy.tf >> storage_bucket_iam_policy.tf
#	cat ../templates/storage_default_object_acl.tf >> storage_default_object_acl.tf

service-account: name-required
	cat ../templates/service_account.tf >> service_account.tf
	sed -i '' -e "s!its-test!$${NAME}!g" service_account.tf

.PHONY: gke mysql postgresql redis service-account

# Import utils

terraformer:
	terraformer import google \
		--resources=backendServices,forwardingRules,globalForwardingRules,healthChecks,httpHealthChecks,httpsHealthChecks,targetPools,regionBackendServices,targetHttpProxies,targetHttpsProxies,targetTcpProxies \
		--regions=asia-east1,global \
		--projects=myproject

format:
	find generated -name "*.tf" -type f | xargs sed -i '' 's/tfer--//g'
	find generated -name "*.tf" -type f | xargs sed -i '' 's/002D-//g'
	find generated -name "*.tf" -type f | xargs sed -i '' 's/002F-//g'
