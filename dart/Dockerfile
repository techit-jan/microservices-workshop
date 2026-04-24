FROM dart:stable AS builder

WORKDIR /app

COPY pubspec.* ./
RUN dart pub get

COPY . .

RUN dart compile exe main.dart -o server


FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/server /app/server

EXPOSE 8086

ENTRYPOINT ["/app/server"]