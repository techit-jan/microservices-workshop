#Variables
export TAG="latest"
export DATABASE_URI="11.1.111.11"
export REDIS_ENDPOINT="22.2.222.22"

bash -n main.sh

shellcheck main.sh

bats unit_test.bats

docker build -t bashja:${TAG} .

docker build -t bashja:latest .

docker run -d -p 8088:8088 --name bashja -e DATABASE_URI=${DATABASE_URI} -e REDIS_ENDPOINT=${REDIS_ENDPOINT} bashja:${TAG}