const express = require("express");

const app = express();
app.use(express.json()); // รองรับ JSON

function log({ level, fields }) {
    console.log(
      JSON.stringify({
        timestamp: new Date().toISOString(),
        level,
        fields,
      })
    );
  }

// API: GET
app.get("/hello-world", (req, res) => {
    log({
        level: "INFO",
        fields: {
          code: "200",
          service: "hello-world",
          employee_id: "1111",
          message: "Hello World",
        },
    });

    res.json({
      code: "200",
      message: "Hello World",
    });
});

// API: GET
app.get("/env-variable", (req, res) => {
    log({
        level: "INFO",
        fields: {
          code: "200",
          service: "env-variable",
          employee_id: "1111",
          message: "Success",
        },
    });

    res.json({
      code: "200",
      message: "Success",
      config: {
        database_uri: process.env.DATABASE_URI,
        redis_endpoint: process.env.REDIS_ENDPOINT,
      }
    });
});

// start server
app.listen(8083, () => {
  console.log("Server running on http://localhost:8083");
});