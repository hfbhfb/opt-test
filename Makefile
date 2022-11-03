
all:
	#docker run --rm --env CGO_ENABLED=0 -v "$PWD":/usr/src/mygoapp -w /usr/src/mygoapp golang:1.18 go build -ldflags '-s' -v
	docker run --rm --env CGO_ENABLED=0 -v $(shell pwd):/usr/src/mygoapp -w /usr/src/mygoapp golang:1.18 go build -ldflags '-s' -v
	docker image build -t mygoapp:v0.0.1 .
	# docker history mygoapp:v0.0.1 --no-trunc
	# docker run --name mygoapp -itd mygoapp:v0.0.1
	# docker exec -it mygoapp /bin/sh

