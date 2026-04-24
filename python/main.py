import logging
import json
from datetime import datetime
import os
from fastapi import FastAPI
class CustomJsonFormatter(logging.Formatter):
    def format(self, record):
        log = {
            "timestamp": datetime.utcnow().isoformat() + "Z",
            "level": record.levelname,
            "fields": {
                "code": getattr(record, "code", None),
                "service": getattr(record, "service", None),
                "employee_id": getattr(record, "employee_id", None),
                "message": record.getMessage(),
            },
            "target": record.name,
        }
        return json.dumps(log)

logger = logging.getLogger("helloworld")
logger.setLevel(logging.INFO)

handler = logging.StreamHandler()
handler.setFormatter(CustomJsonFormatter())
logger.addHandler(handler)

app = FastAPI()

@app.get("/hello-world")
def helloworld():
    logger.info(
        "Hello World",
        extra={
            "code": "200",
            "service": "hello-world",
            "employee_id": "1111"
        }
    )
    return {"code": "200","message": "Hello World"}

@app.get("/env_variable")
def env_variable():
    database_uri = os.getenv("DATABASE_URI")
    redis_endpoint = os.getenv("REDIS_ENDPOINT")
    logger.info(
        "Env Variable",
        extra={
            "code": "200",
            "service": "env_variable",
            "employee_id": "1111",
            "database_uri": database_uri,
            "redis_endpoint": redis_endpoint
        }
    )
    return {"code": "200","message": "Success", "config": {"database_uri": database_uri, "redis_endpoint": redis_endpoint}}

def add(a: int, b: int) -> int:
    return a + b

def bad_add(a: int, b: int) -> int:
    return a - b