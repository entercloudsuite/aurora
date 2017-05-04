router := $(shell openstack router list -c Name -f value)
deploy: converge
	openstack floating ip list

create: 
ifeq (${router},)
	ansible-playbook setup.yml
	molecule create
else
	@echo '********************************************************************'
	@echo ''
	@echo '***** YOU MUST USE AN EMPTY REGION TO CREATE AN AURORA CLUSTER *****'
	@echo ''
	@echo '********************************************************************'
endif

login:
	molecule login --host $(host)	

converge:
	molecule syntax 
	molecule converge

test:
	molecule verify

galaxy-install:
	ansible-galaxy install -r requirements.yml -p roles

destroy:
	molecule destroy
	ansible-playbook clean.yml