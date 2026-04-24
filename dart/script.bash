#Variables
export TAG="latest"
export DATABASE_URI="11.1.111.11"
export REDIS_ENDPOINT="22.2.222.22"

dart analyze

dart test

docker build -t dartja:${TAG} .

docker build -t dartja:latest .


docker run -d -p 8086:8086 --name dartja -e DATABASE_URI=${DATABASE_URI} -e REDIS_ENDPOINT=${REDIS_ENDPOINT} dartja:${TAG}

docker run -d -p 8086:8086 --name dartja -e DATABASE_URI=11.1.111.11 -e REDIS_ENDPOINT=22.2.222.22 dartja:latest