all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container

build: builddocker beep

run: hostname datadir builddocker rundocker beep

rundocker:
	@docker run --name=docker-salt-minion \
	--cidfile="cid" \
	-v /tmp:/tmp \
	-v `cat datadir`:/etc/salt \
	-h `cat hostname` \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	-t thalhalla/docker-salt-minion

builddocker:
	/usr/bin/time -v docker build -t thalhalla/docker-salt-minion .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	@docker kill `cat cid`

rm-image:
	@docker rm `cat cid`
	@rm cid

rm: kill rm-image

enter:
	docker exec -i -t `cat cid` /bin/bash

hostname:
	@while [ -z "$$HOSTNAME" ]; do \
		read -r -p "Enter the hostname you wish to associate with this salt container [hostNAME]: " HOSTNAME; echo "$$HOSTNAME">>hostname; cat hostname; \
	done ;

datadir:
	@while [ -z "$$datadir" ]; do \
		read -r -p "Enter the datadir you wish to associate with this salt container [datadir]: " datadir; echo "$$datadir">>datadir; cat datadir; \
	done ;
