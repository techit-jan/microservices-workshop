#Variables
export TAG="latest"
export DATABASE_URI="11.1.111.11"
export REDIS_ENDPOINT="22.2.222.22"

go fmt ./... 

go vet ./... 

go test ./...

docker build -t goja:$TAG .

docker run -d -p 8085:8085 --name goja -e DATABASE_URI=$DATABASE_URI -e REDIS_ENDPOINT=$REDIS_ENDPOINT goja:$TAG
