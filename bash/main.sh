#!/bin/bash

PORT=8080

log_json() {
  local message="$1"

  local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  echo "{
    \"timestamp\": \"$timestamp\",
    \"level\": \"INFO\",
    \"fields\": $message
  }"
}

handle_request() {
  read request_line

  method=$(echo "$request_line" | awk '{print $1}')
  path=$(echo "$request_line" | awk '{print $2}')

  # อ่าน header ทิ้ง
  while read header && [ "$header" != $'\r' ]; do :; done

  if [[ "$method" == "GET" && "$path" == "/hello-world" ]]; then

    fields='{
      "code": "200",
      "service": "hello-world",
      "employee_id": "1111",
      "message": "Hello World"
    }'

    # 🔥 log
    log_json "$fields"

    # 🔥 response
    response='{
      "code": "200",
      "message": "Hello World"
    }'

    echo -e "HTTP/1.1 200 OK\r"
    echo -e "Content-Type: application/json\r"
    echo -e "Content-Length: ${#response}\r"
    echo -e "\r"
    echo -e "$response"

  else
    echo -e "HTTP/1.1 404 Not Found\r"
    echo -e "\r"
  fi
}

echo "Server running on port $PORT..."

while true; do
  nc -l 8080 | handle_request
done