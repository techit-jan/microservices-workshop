FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /src

COPY demo-api/demo-api.csproj demo-api/
RUN dotnet restore demo-api/demo-api.csproj

COPY demo-api/ demo-api/

RUN dotnet publish demo-api/demo-api.csproj \
    -c Release \
    -o /app/publish


FROM mcr.microsoft.com/dotnet/aspnet:10.0

WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8087

ENV ASPNETCORE_URLS=http://+:8087

ENTRYPOINT ["dotnet", "demo-api.dll"]