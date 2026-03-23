package com.example.helloworld;

// Spring types for constructing HTTP responses and controller annotations
import org.springframework.http.ResponseEntity; // used to build HTTP responses with status and body
import org.springframework.web.bind.annotation.GetMapping; // maps HTTP GET to a method
import org.springframework.web.bind.annotation.RestController; // marks this class as a REST controller

// SLF4J logging API
import org.slf4j.Logger; // logging interface
import org.slf4j.LoggerFactory; // used to create `Logger` instances

// Jackson for converting Java objects to JSON strings for logging
import com.fasterxml.jackson.databind.ObjectMapper; // serializes objects to JSON

// Java utility/time classes
import java.time.Instant; // current timestamp in ISO-8601 format
import java.util.LinkedHashMap; // preserves insertion order for JSON-like maps
import java.util.Map; // generic Map interface used for response and log data

@RestController // Spring will detect this class and expose its request mappings as REST endpoints
public class HelloWorldController {
    // Create a logger named "helloworld"; used to write log messages to console
    private static final Logger logger = LoggerFactory.getLogger("helloworld");

    // Jackson ObjectMapper for converting the structured log map into a JSON string
    private final ObjectMapper mapper = new ObjectMapper();

    @GetMapping("/hello-world") // when GET /hello-world is called, invoke the `hello()` method
    public ResponseEntity<Map<String, Object>> hello() {
        // Build the HTTP response body that will be returned to the client
        Map<String, Object> body = Map.of("code", 200, "message", "helloworld");

        // Build the inner `fields` object for structured logging (keeps insertion order)
        Map<String, Object> fields = new LinkedHashMap<>();
        fields.put("code", "200"); // string form of HTTP code for logs
        fields.put("service", "hello-world"); // service name
        fields.put("employee_id", "1111"); // example metadata (employee id)
        fields.put("message", "Hello World"); // human message for the log

        // Build the outer structured log map
        Map<String, Object> log = new LinkedHashMap<>();
        log.put("timestamp", Instant.now().toString()); // current time in ISO-8601
        log.put("level", "INFO"); // log level
        log.put("fields", fields); // nested fields object
        log.put("target", "helloworld"); // logging target/name

        try {
            // Serialize the `log` map to a compact JSON string
            String json = mapper.writeValueAsString(log);
            // Write the JSON string to the logger (console via logback)
            logger.info(json);
        } catch (Exception e) {
            // Fallback: if serialization fails, log the map using `toString()`
            logger.info(log.toString());
        }

        // Return HTTP 200 with the body map (Spring will serialize to JSON automatically)
        return ResponseEntity.ok(body);
    }
}
