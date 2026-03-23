using System;
using System.IO;
using Serilog.Events;
using Serilog.Formatting;

public class Logger : ITextFormatter
{
    public void Format(LogEvent logEvent, TextWriter output)
    {
        var timestamp = logEvent.Timestamp.ToString("o");
        var level = logEvent.Level.ToString().ToUpper();

        object fields = null;

        if (logEvent.Properties.ContainsKey("fields"))
        {
            var value = logEvent.Properties["fields"].ToString();
            fields = value;
        }

        var json = $@"
{{
  ""timestamp"": ""{timestamp}"",
  ""level"": ""{level}"",
  ""fields"": {logEvent.Properties["fields"]}
}}";

        output.WriteLine(json);
    }
}