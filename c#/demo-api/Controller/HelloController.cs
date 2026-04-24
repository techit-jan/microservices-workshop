using Microsoft.AspNetCore.Mvc;

namespace demo_api.Controllers;

[ApiController]
[Route("")]
public class HelloController : ControllerBase
{
    private readonly ILogger<HelloController> _logger;

    public HelloController(ILogger<HelloController> logger)
    {
        _logger = logger;
    }

    [HttpGet("hello-world")]
    public IActionResult Get()
    {
        var fields = new
        {
            code = "200",
            service = "hello-world",
            employee_id = "1111",
            message = "Hello World"
        };

        _logger.LogInformation("{@fields}", fields);

        return Ok(new
        {
            code = "200",
            message = "Hello World"
        });
    }

    [HttpGet("env-variable")]
    public IActionResult GetEnv()
    {
        var databaseUri = Environment.GetEnvironmentVariable("DATABASE_URI");
        var redisEndpoint = Environment.GetEnvironmentVariable("REDIS_ENDPOINT");

        var fields = new
        {
            code = "200",
            service = "env-variable",
            employee_id = "1111",
            message = "Success"
        };

        _logger.LogInformation("{@fields}", fields);

        return Ok(new
        {
            code = "200",
            message = "Success",
            config = new
            {
                database_uri = databaseUri,
                redis_endpoint = redisEndpoint
            }
        });
    }
}