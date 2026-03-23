use actix_web::{get, web, App, HttpServer, Responder};
use serde::Serialize;
use tracing::{info}; // Log
use tracing_subscriber; // Log Setting

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

#[actix_web::main] // or #[tokio::main]
async fn main() -> std::io::Result<()> {
    init_logger();
    HttpServer::new(|| {
        App::new().service(helloworld)
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await
}