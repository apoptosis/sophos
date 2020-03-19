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

docker-up: docker-build
	docker-compose -f etc/docker-compose.yml up

deploy:
	docker save -o /tmp/sophos.bin sophos
