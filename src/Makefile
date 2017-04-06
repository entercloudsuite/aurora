deploy: converge

create: 
	make security
	molecule create

login:
	molecule login --host $(host)	

converge:
	molecule syntax 
	molecule converge

test:
	molecule verify

galaxy-install:
	ansible-galaxy install -r requirements.yml -p roles

security:
	chmod +x sec.sh
	./sec.sh

destroy:
	# destroys the two machines and the security group (not the keypairs)
	openstack server delete ansible-dockerswarm-manager
	openstack server delete ansible-dockerswarm-worker
	openstack security group delete aurora_security_group
