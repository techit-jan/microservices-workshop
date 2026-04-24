<?php
require_once __DIR__ . "/test_function.php";

header("Content-Type: application/json");
$path = "main.php";

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$method = $_SERVER['REQUEST_METHOD'];

function log_json($level, $meta = []) {
    $log = [
        "timestamp" => gmdate("c"),
        "level" => $level,
        "fields" => $meta
    ];

    file_put_contents("php://stdout", json_encode($log) . PHP_EOL);
}

// routing
if ($uri === '/'.$path.'/hello-world' && $method === 'GET') {
    http_response_code(200);

    log_json("INFO", [
        "code" => "200",
        "service" => "hello-world",
        "employee_id" => "1111",
        "message" => "Hello World"
    ]);

    echo json_encode([
        "code" => "200",
        "message" => "Hello World"
    ]);
    exit;
}

// routing
if ($uri === '/'.$path.'/env_variable' && $method === 'GET') {
    http_response_code(200);

    $database_uri = getenv("DATABASE_URI");
    $redis_endpoint = getenv("REDIS_ENDPOINT");

    log_json("INFO", [
        "code" => "200",
        "service" => "env_variable",
        "employee_id" => "1111",
        "message" => "Success"
    ]);

    echo json_encode([
        "code" => "200",
        "message" => "Success",
        "config" => [
            "database_uri" => $database_uri,
            "redis_endpoint" => $redis_endpoint
        ]
    ]);
    exit;
}

echo $uri;
// default
http_response_code(404);
echo json_encode([
    "error" => "Not Found"
]);