FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["ApiProjeKampi.WebApi/ApiProjeKampi.WebApi.csproj", "ApiProjeKampi.WebApi/"]
RUN dotnet restore "ApiProjeKampi.WebApi/ApiProjeKampi.WebApi.csproj"

COPY ApiProjeKampi.WebApi/ ApiProjeKampi.WebApi/
WORKDIR "/src/ApiProjeKampi.WebApi"
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "ApiProjeKampi.WebApi.dll"]