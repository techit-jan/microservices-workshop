<?php

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

echo $uri;
// default
http_response_code(404);
echo json_encode([
    "error" => "Not Found"
]);