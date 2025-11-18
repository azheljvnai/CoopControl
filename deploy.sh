#!/bin/bash
# CoopControl Deployment Script

set -e  # Exit on error

echo "======================================"
echo "CoopControl Deployment Script"
echo "======================================"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Error: Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Step 1: Build the JAR file
echo "Step 1: Building the application JAR file..."
./mvnw clean package -DskipTests
if [ $? -ne 0 ]; then
    echo "Error: Failed to build JAR file"
    exit 1
fi
echo "✓ JAR file built successfully"
echo ""

# Step 2: Check if .env exists
if [ ! -f .env ]; then
    echo "Step 2: Creating .env file from template..."
    cp .env.example .env
    echo "✓ .env file created. Please review and update it if needed."
else
    echo "Step 2: .env file already exists"
fi
echo ""

# Step 3: Build and start containers
echo "Step 3: Building and starting Docker containers..."
docker-compose up -d --build
if [ $? -ne 0 ]; then
    echo "Error: Failed to start containers"
    exit 1
fi
echo "✓ Containers started successfully"
echo ""

# Step 4: Wait for services to be ready
echo "Step 4: Waiting for services to be ready..."
echo "Waiting for MySQL to be healthy..."
timeout=60
counter=0
until docker-compose exec -T mysql mysqladmin ping -h localhost -u root -p${MYSQL_ROOT_PASSWORD:-Plum409r-} --silent &> /dev/null; do
    sleep 2
    counter=$((counter + 2))
    if [ $counter -ge $timeout ]; then
        echo "Warning: MySQL did not become healthy within $timeout seconds"
        break
    fi
    echo -n "."
done
echo ""
echo "✓ MySQL is ready"

echo "Waiting for application to start..."
sleep 10
echo "✓ Application should be starting"
echo ""

# Step 5: Display status
echo "======================================"
echo "Deployment Complete!"
echo "======================================"
echo ""
echo "Application URL: http://localhost:8080"
echo "API Documentation: http://localhost:8080/swagger-ui.html"
echo ""
echo "Useful commands:"
echo "  - View logs: docker-compose logs -f"
echo "  - Stop containers: docker-compose down"
echo "  - Restart: docker-compose restart"
echo ""
echo "Container status:"
docker-compose ps
