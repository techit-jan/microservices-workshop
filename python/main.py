import logging
import json
from datetime import datetime
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