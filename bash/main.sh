#!/bin/bash

PORT=8088

log_json() {
  local message="$1"
  local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  echo "{
    \"timestamp\": \"$timestamp\",
    \"level\": \"INFO\",
    \"fields\": $message
  }" >&2
}

handle_request() {
  read request_line

  method=$(echo "$request_line" | awk '{print $1}')
  path=$(echo "$request_line" | awk '{print $2}')

  while read header && [ "$header" != $'\r' ]; do :; done

  if [[ "$method" == "GET" && "$path" == "/hello-world" ]]; then
    fields='{
      "code": "200",
      "service": "hello-world",
      "employee_id": "1111",
      "message": "Hello World"
    }'

    log_json "$fields"

    response='{
      "code": "200",
      "message": "Hello World"
    }'

    echo -e "HTTP/1.1 200 OK\r"
    echo -e "Content-Type: application/json\r"
    echo -e "Content-Length: ${#response}\r"
    echo -e "\r"
    echo -e "$response"

  elif [[ "$method" == "GET" && "$path" == "/env-variable" ]]; then
    database_uri="${DATABASE_URI}"
    redis_endpoint="${REDIS_ENDPOINT}"

    fields='{
      "code": "200",
      "service": "env-variable",
      "employee_id": "1111",
      "message": "Success"
    }'

    log_json "$fields"

    response="{
      \"code\": \"200\",
      \"message\": \"Success\",
      \"config\": {
        \"database_uri\": \"${database_uri}\",
        \"redis_endpoint\": \"${redis_endpoint}\"
      }
    }"

    echo -e "HTTP/1.1 200 OK\r"
    echo -e "Content-Type: application/json\r"
    echo -e "Content-Length: ${#response}\r"
    echo -e "\r"
    echo -e "$response"

  else
    response='{"error":"Not Found"}'

    echo -e "HTTP/1.1 404 Not Found\r"
    echo -e "Content-Type: application/json\r"
    echo -e "Content-Length: ${#response}\r"
    echo -e "\r"
    echo -e "$response"
  fi
}

echo "Server running on port $PORT..."

while true; do
  FIFO=$(mktemp -u)
  mkfifo "$FIFO"

  cat "$FIFO" | nc -l -p "$PORT" | handle_request > "$FIFO"

  rm -f "$FIFO"
done