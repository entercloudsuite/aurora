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

