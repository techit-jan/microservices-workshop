use actix_web::{get, web, App, HttpServer, Responder};
use serde::Serialize;
use tracing::{info}; // Log
use tracing_subscriber; // Log Setting
use std::env; //env

fn init_logger() {
    tracing_subscriber::fmt()
    .json()
    .init();
}

#[derive(Serialize)]
struct ApiResponse {
    code: String,
    message: String
}

#[derive(Serialize)]
struct Config {
    database_uri: String,
    redis_endpoint: String,
}

#[derive(Serialize)]
struct ApiResponseEnv {
    code: String,
    message: String,
    config: Config,
}

#[get("/hello-world")]
async fn helloworld() -> impl Responder {
    let response = ApiResponse {
        code: "200".to_string(),
        message: "Hello World".to_string()
    };
    info!(
        code = "200".to_string(),
        service = "hello-world".to_string(),
        employee_id = "1111".to_string(),
        message = "Hello World".to_string()
    );
    web::Json(response)
}

#[get("/env_variable")]
async fn env_variable() -> impl Responder {
    let database_uri = env::var("DATABASE_URI")
        .expect("DATABASE_URI must be set");

    let redis_endpoint = env::var("REDIS_ENDPOINT")
        .expect("REDIS_ENDPOINT must be set");

    info!(
        code = "200".to_string(),
        service = "hello-world".to_string(),
        employee_id = "1111".to_string(),
        message = format!("Database URI: {}, Redis Endpoint: {}", database_uri, redis_endpoint)
    );

    let response = ApiResponseEnv {
        code: "200".to_string(),
        message: format!("Success"),
        config: Config {
            database_uri: database_uri,
            redis_endpoint: redis_endpoint
        }
    };
    web::Json(response)
}

#[actix_web::main] // or #[tokio::main]
async fn main() -> std::io::Result<()> {
    init_logger();
    HttpServer::new(|| {
        App::new().service(helloworld)
                  .service(env_variable)
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await
}

pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

// This is a really bad adding function, its purpose is to fail in this
// example.
#[allow(dead_code)]
fn bad_add(a: i32, b: i32) -> i32 {
    a - b
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(1, 2), 3);
    }
}