# Use the official .NET SDK image to build and publish the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy the csproj and restore as distinct layers
COPY QuizServer/QuizServer/*.csproj ./QuizServer/
RUN dotnet restore ./QuizServer/QuizServer.csproj

# Copy the entire project and build the release
COPY QuizServer/QuizServer/. ./QuizServer/
WORKDIR /app/QuizServer
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/QuizServer/out .

# Expose the port the app runs on
EXPOSE 5045

# Set the entry point for the container
ENTRYPOINT ["dotnet", "QuizServer.dll"]