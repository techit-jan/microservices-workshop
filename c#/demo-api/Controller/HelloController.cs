using Microsoft.AspNetCore.Mvc;

namespace demo_api.Controllers;

[ApiController]
[Route("hello-world")]
public class HelloController : ControllerBase
{
    private readonly ILogger<HelloController> _logger;

    public HelloController(ILogger<HelloController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public IActionResult Get()
    {
        var fields = new
        {
            code = "200",
            service = "hello-world",
            employee_id = "1111",
            message = "Hello World"
        };

        // ✅ log เฉพาะตอนเรียก endpoint
        _logger.LogInformation("{@fields}", fields);

        return Ok(new
        {
            code = "200",
            message = "Hello World"
        });
    }
}