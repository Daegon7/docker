@echo off
echo ===============================================
echo  Spring Boot Docker Auto Runner (Enhanced)
echo ===============================================
echo.

echo [1/4] Stopping existing containers...
docker-compose down

echo.
echo [2/4] Removing any leftover containers...
docker rm -f docker-container 2>nul

echo.
echo [3/4] Building and starting containers...
docker-compose up --build -d

echo.
echo [4/4] Application is ready!
echo URL: http://localhost:8085
echo Container: docker-container
echo.

echo Checking container status...
docker ps --filter "name=docker-container"

echo.
echo Press any key to view logs...
pause >nul
docker-compose logs -f app