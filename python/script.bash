#Variables
export TAG="latest"
export DATABASE_URI="11.1.111.11"
export REDIS_ENDPOINT="22.2.222.22"

python -m compileall .

pytest

docker build -t pythonja:$TAG .

docker run -d -p 8081:8081 --name pythonja -e DATABASE_URI=$DATABASE_URI -e REDIS_ENDPOINT=$REDIS_ENDPOINT pythonja:$TAG