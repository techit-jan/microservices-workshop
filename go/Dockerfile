# ---------- stage 1: build ----------
FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

# ---------- stage 2: runtime ----------
FROM alpine:latest

WORKDIR /app

# copy binary อย่างเดียว
COPY --from=builder /app/app .

EXPOSE 8085

CMD ["./app"]