# Use the official ASP.NET Core runtime as a base image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5158  # Match the port used in launchSettings.json

# Use the .NET SDK to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["SimpleAPIWith_CICD/SimpleAPIWith_CICD.csproj", "SimpleAPIWith_CICD/"]
RUN dotnet restore "SimpleAPIWith_CICD/SimpleAPIWith_CICD.csproj"

# Copy the rest of the application source code
COPY . . 
WORKDIR "/src/SimpleAPIWith_CICD"
RUN dotnet build "SimpleAPIWith_CICD.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "SimpleAPIWith_CICD.csproj" -c Release -o /app/publish

# Final stage: Use the ASP.NET Core runtime to run the app
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .  
ENTRYPOINT ["dotnet", "SimpleAPIWith_CICD.dll"]
