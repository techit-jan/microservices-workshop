FROM rust:alpine AS builder

WORKDIR /app

COPY . .

RUN cargo build --release

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/target/release/helloworld .

EXPOSE 8080

ENTRYPOINT ["./helloworld"]
CMD ["--host", "0.0.0.0"]