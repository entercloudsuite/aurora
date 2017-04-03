all: converge test

create:
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