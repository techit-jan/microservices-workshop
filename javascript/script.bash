#Variables
export TAG="latest"
export DATABASE_URI="11.1.111.11"
export REDIS_ENDPOINT="22.2.222.22"

node --check main.js

node --test

docker build -t javascriptja:$TAG .

docker run -d -p 8083:8083 --name javascriptja -e DATABASE_URI=$DATABASE_URI -e REDIS_ENDPOINT=$REDIS_ENDPOINT javascriptja:latest
