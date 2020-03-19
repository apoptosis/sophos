all: clean init

clean:
	-rm -f ./sophoslib

build:
	-rm -rf ./sophoslib
	mkdir sophoslib
	emacs --batch -q -l ./etc/build.el  --eval "(build-all \"${PWD}/sophoslib/\")"

run:
	make build
	etc/start-local.sh

docker-build:
	docker-compose -f etc/docker-compose.yml build

docker-up:
	make docker-build
	docker-compose -f etc/docker-compose.yml up -d

docker-down:
	docker-compose -f etc/docker-compose.yml down

deploy-up:
	rsync --progress --inplace -r ./ root@ldlework.com:/root/sophos/
	ssh -t root@ldlework.com "cd sophos && make docker-up"

deploy-down:
	ssh -t root@ldlework.com "cd sophos && make docker-down"

deploy-restart:
	make deploy-down
	make deploy-up
