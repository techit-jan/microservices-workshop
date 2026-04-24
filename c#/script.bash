#Variables
export TAG="latest"
export DATABASE_URI="11.1.111.11"
export REDIS_ENDPOINT="22.2.222.22"

dotnet build

dotnet test

docker build -t csharpja:$TAG .

docker build -t csharpja:latest .

docker run -d -p 8087:8087 --name csharpja -e DATABASE_URI=$DATABASE_URI -e REDIS_ENDPOINT=$REDIS_ENDPOINT csharpja:$TAG

docker run -d -p 8087:8087 --name csharpja -e DATABASE_URI=11.1.111.11 -e REDIS_ENDPOINT=22.2.222.22 csharpja:latest