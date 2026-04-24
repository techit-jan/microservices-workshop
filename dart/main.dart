import 'dart:io';
import 'dart:convert';

void logInfo(Map<String, dynamic> fields) {
  final log = {
    "timestamp": DateTime.now().toUtc().toIso8601String(),
    "level": "INFO",
    "fields": fields,
  };

  print(jsonEncode(log));
}

void main() async {
  final server = await HttpServer.bind('0.0.0.0', 8086);
  print('Server running on http://localhost:8086');

  await for (HttpRequest request in server) {
    if (request.uri.path == '/hello-world') {
      
      final responseData = {
        "code": "200",
        "message": "Hello World",
      };

      // ✅ ใช้ logger
      logInfo({
        "code": "200",
        "service": "hello-world",
        "employee_id": "1111",
        "message": "Hello World"
      });

      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(responseData));

    }else if (request.uri.path == '/env-variable') {
      
      final responseData = {
        "code": "200",
        "message": "Success",
        "config": {
          "database_uri": Platform.environment['DATABASE_URI'] ?? 'Not Set',
          "redis_endpoint": Platform.environment['REDIS_ENDPOINT'] ?? 'Not Set',
        }
      };

      // ✅ ใช้ logger
      logInfo({
        "code": "200",
        "service": "env-variable",
        "employee_id": "1111",
        "message": "Success"
      });

      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(responseData));

    } 
     else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..headers.contentType = ContentType.json
        ..write(jsonEncode({
          "code": "404",
          "message": "Not Found"
        }));
    }

    await request.response.close();
  }
}