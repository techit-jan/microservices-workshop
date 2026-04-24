#Variables
export TAG="latest"
export DATABASE_URI="11.1.111.11"
export REDIS_ENDPOINT="22.2.222.22"

php -l main.php

./vendor/bin/phpunit tests

docker build -t phpja:latest .

docker run -d -p 8082:8082 --name phpja -e DATABASE_URI=$DATABASE_URI -e REDIS_ENDPOINT=$REDIS_ENDPOINT phpja:latest
