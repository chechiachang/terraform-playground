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

# IAM
#
# USER=terraform GROUP=infra-admin make user
user:
	if [ -z ${USER} ]; then echo 'USER env is required.' && exit 1; fi
	if [ -z ${GROUP} ]; then echo 'GROUP env is required.' && exit 1; fi
	cat ../templates/iam_user.tf >> iam_user.tf
	sed -i '' -e  "s!my-user!$${USER}!g" iam_user.tf
	cat ../templates/iam_user_group_membership.tf >> iam_user_group_membership.tf
	sed -i '' -e  "s!my-user!$${USER}!g" iam_user_group_membership.tf
	sed -i '' -e  "s!my-group!$${GROUP}!g" iam_user_group_membership.tf

group:
	if [ -z ${GROUP} ]; then echo 'GROUP env is required.' && exit 1; fi
	cat ../templates/iam_group.tf >> iam_group.tf
	sed -i '' -e  "s!my-group!$${GROUP}!g" iam_group.tf

# EC2

name-required:
	if [ -z ${NAME} ]; then echo 'NAME env is required.' && exit 1; fi

# NAME=my-web-instance make ec2
KEY=$(shell cat ~/.ssh/aws.pub)
ec2: name-required
	cat ../templates/aws_instance.tf >> aws_instance.tf
	sed -i '' -e  "s!my-instance!$${NAME}!g" aws_instance.tf
	cat ../templates/aws_key_pair.tf >> aws_key_pair.tf
	sed -i '' -e  "s!my-instance!$${NAME}!g" aws_key_pair.tf
	sed -i '' -e  "s!my-public-key!$(KEY)!g" aws_key_pair.tf

.PHONY: user group

# Import utils

terraformer:
	terraformer import aws --resources=iam --regions=ap-northeast-1

format:
	find generated -name "*.tf" -type f | xargs sed -i '' 's/tfer--//g'
	find generated -name "*.tf" -type f | xargs sed -i '' 's/002D-//g'
	find generated -name "*.tf" -type f | xargs sed -i '' 's/002F-//g'
