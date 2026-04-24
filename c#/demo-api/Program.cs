using Serilog;
using Serilog.Formatting.Json;

var builder = WebApplication.CreateBuilder(args);

Log.Logger = new LoggerConfiguration()
    .MinimumLevel.Information()
    .MinimumLevel.Override("Microsoft", Serilog.Events.LogEventLevel.Error)
    .MinimumLevel.Override("System", Serilog.Events.LogEventLevel.Error)
    .WriteTo.Console(new Logger())
    .CreateLogger();

builder.Host.UseSerilog();

builder.Services.AddControllers();

builder.WebHost.UseUrls("http://0.0.0.0:8087");

var app = builder.Build();

app.MapControllers();

app.Run();