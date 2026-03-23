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

// start server
app.listen(8000, () => {
  console.log("Server running on http://localhost:8000");
});