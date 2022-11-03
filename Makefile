
all:
	docker run --rm --env CGO_ENABLED=0 -v "$PWD":/usr/src/mygoapp -w /usr/src/mygoapp golang go build -ldflags '-s' -v
	docker image build -t mygoapp:v0.0.1 .

