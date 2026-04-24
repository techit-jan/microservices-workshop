FROM php:8.3-cli-alpine AS builder

WORKDIR /app

COPY main.php .
COPY test_function.php .
COPY tests tests

RUN php -l main.php


FROM php:8.3-cli-alpine

WORKDIR /app

COPY --from=builder /app/main.php /app/main.php
COPY --from=builder /app/test_function.php /app/test_function.php
COPY --from=builder /app/tests /app/tests

EXPOSE 8082

ENTRYPOINT ["php", "-S", "0.0.0.0:8082", "main.php"]