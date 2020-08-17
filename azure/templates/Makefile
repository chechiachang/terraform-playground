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

# NAME=my-new-vm make vm
vm: name-required
	cat ../templates/virtual_machine.tf >> virtual_machine.tf
	sed -i '' -e  "s!my-virtual-machine!$${NAME}!g" *.tf

.PHONY: vm

# Import utils
# https://github.com/GoogleCloudPlatform/terraformer#use-with-azure
# export ARM_SUBSCRIPTION_ID=[SUBSCRIPTION_ID]
terraformer:
	terraformer import google \
		--resources=container,database,disk,dns,load_balancer,network_interface,resource_group,virtual_machine,virtual_network \
		--regions=global

format:
	find generated -name "*.tf" -type f | xargs sed -i '' 's/tfer--//g'
	find generated -name "*.tf" -type f | xargs sed -i '' 's/002D-//g'
