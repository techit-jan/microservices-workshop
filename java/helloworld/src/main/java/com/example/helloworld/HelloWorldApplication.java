package com.example.helloworld; // package declaration: groups related classes and determines the folder structure

// Spring Boot helper that launches the application
import org.springframework.boot.SpringApplication; // provides static `run()` to start the Spring context
import org.springframework.boot.autoconfigure.SpringBootApplication; // enables auto-configuration and component scanning

@SpringBootApplication // meta-annotation: @Configuration + @EnableAutoConfiguration + @ComponentScan
public class HelloWorldApplication {
    // Main JVM entry point for the Spring Boot application
    public static void main(String[] args) {
        // Start Spring application context, create embedded server and deploy this app
        // First parameter: primary source (this class) used for component scanning/config
        // Second parameter: command-line args forwarded into the Spring environment
        SpringApplication.run(HelloWorldApplication.class, args);
    }
}
