FROM alpine:latest AS builder

WORKDIR /app

COPY main.sh .

RUN sed -i 's/\r$//' main.sh
RUN chmod +x main.sh


FROM alpine:latest

WORKDIR /app

RUN apk add --no-cache bash netcat-openbsd

COPY --from=builder /app/main.sh /app/main.sh

RUN chmod +x /app/main.sh

EXPOSE 8088

ENTRYPOINT ["/app/main.sh"]