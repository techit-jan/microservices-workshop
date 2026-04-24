#Variables
export TAG="latest"
export DATABASE_URI="11.1.111.11"
export REDIS_ENDPOINT="22.2.222.22"

mvn compile

mvn test

docker build -t javaja:$TAG .

docker run -d -p 8084:8084 --name javaja -e DATABASE_URI=$DATABASE_URI -e REDIS_ENDPOINT=$REDIS_ENDPOINT javaja:$TAG