SUBDIRS := $(filter-out modules/. templates/. credentials/., $(wildcard */.))

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ plan

diff:
	for d in $(SUBDIRS); do echo =====$${d}=====; grep '+\|~\|destroy' $${d}/output; done

.PHONY: all $(SUBDIRS)

dir-required:
	if [ -z ${DIR} ]; then echo 'DIR env is required.' && exit 1; fi

# Usage: DIR=myproject-oolong make project
project: dir-required
	mkdir ${DIR}
	cd ${DIR}; ln -s ../templates/Makefile Makefile; \
		ln -s ../templates/provider.tf provider.tf; \
		cp ../templates/variables.tf variables.tf; \
		cp ../templates/terraform.tf terraform.tf
	@echo "Usage:"
	@echo "cd ${DIR}; NAME=prod-testing make gke mysql postgresql redis"

test:
	DIR=test-project make project
	NAME=prod-testing $(MAKE) -C test-project gke mysql postgresql redis

# AWS credentials

init:
	cp $${HOME}/.aws/credentials credentials
