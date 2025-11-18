# CoopControl Deployment Guide

This guide provides instructions for deploying the CoopControl application using Docker and Docker Compose.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (version 20.10 or later)
- [Docker Compose](https://docs.docker.com/compose/install/) (version 2.0 or later)
- At least 2GB of available RAM
- Port 8080 (application) and 3306 (MySQL) available on your host machine

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/azheljvnai/CoopControl.git
cd CoopControl
```

### 2. Configure Environment Variables (Optional)

Create a `.env` file from the example:

```bash
cp .env.example .env
```

Edit `.env` to customize your configuration if needed:

```bash
# MySQL Configuration
MYSQL_ROOT_PASSWORD=your_secure_password
```

### 3. Deploy with Docker Compose

Build and start all services:

```bash
docker-compose up -d
```

This command will:
- Build the CoopControl application Docker image
- Pull the MySQL 8.0 image
- Create and start both containers
- Set up a private network for the containers
- Create a persistent volume for MySQL data

### 4. Verify Deployment

Check that all services are running:

```bash
docker-compose ps
```

You should see both `coopcontrol-app` and `coopcontrol-mysql` in a "running" state.

View application logs:

```bash
docker-compose logs -f app
```

### 5. Access the Application

- **Web Application**: http://localhost:8080
- **API Documentation**: http://localhost:8080/swagger-ui.html

## Managing the Deployment

### Stop the Application

```bash
docker-compose down
```

This stops and removes the containers but preserves the MySQL data volume.

### Stop and Remove All Data

```bash
docker-compose down -v
```

⚠️ **Warning**: This will delete all data in the MySQL database.

### Restart the Application

```bash
docker-compose restart
```

### View Logs

View all logs:
```bash
docker-compose logs -f
```

View only application logs:
```bash
docker-compose logs -f app
```

View only MySQL logs:
```bash
docker-compose logs -f mysql
```

### Update the Application

After making code changes:

```bash
# Rebuild the application image
docker-compose build app

# Restart the application
docker-compose up -d app
```

## Production Deployment Considerations

### Security

1. **Change default passwords**: Update the `MYSQL_ROOT_PASSWORD` in your `.env` file
2. **Use environment variables**: Never commit `.env` files with sensitive data to version control
3. **Enable SSL/TLS**: Configure MySQL to use SSL connections in production
4. **Firewall rules**: Restrict access to ports 3306 and 8080

### Performance

1. **Resource limits**: Configure memory and CPU limits in `docker-compose.yml`:
   ```yaml
   services:
     app:
       deploy:
         resources:
           limits:
             cpus: '2'
             memory: 2G
           reservations:
             cpus: '1'
             memory: 1G
   ```

2. **Database tuning**: Adjust MySQL configuration for your workload
3. **Connection pooling**: Configure appropriate connection pool settings in `application.properties`

### High Availability

For production environments, consider:

1. **Using Kubernetes**: See `kubernetes/` directory for manifest files
2. **External database**: Use a managed MySQL service (AWS RDS, Google Cloud SQL, Azure Database)
3. **Load balancing**: Deploy multiple application instances behind a load balancer
4. **Monitoring**: Set up monitoring with Prometheus and Grafana
5. **Logging**: Use centralized logging (ELK Stack, Loki, etc.)

## Manual Deployment (Without Docker)

### Prerequisites

- Java 17 or later
- MySQL 8.0 or later
- Maven 3.6 or later

### Steps

1. **Set up MySQL database**:
   ```sql
   CREATE DATABASE courseproject;
   CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'your_password';
   GRANT ALL PRIVILEGES ON courseproject.* TO 'appuser'@'localhost';
   FLUSH PRIVILEGES;
   ```

2. **Configure application**:
   
   Edit `src/main/resources/application.properties`:
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/courseproject?useSSL=false&serverTimezone=UTC
   spring.datasource.username=appuser
   spring.datasource.password=your_password
   ```

3. **Build the application**:
   ```bash
   ./mvnw clean package
   ```

4. **Run the application**:
   ```bash
   java -jar target/CourseProject-0.0.1-SNAPSHOT.jar
   ```

## Troubleshooting

### Application won't start

1. Check if ports are already in use:
   ```bash
   lsof -i :8080
   lsof -i :3306
   ```

2. Check Docker logs:
   ```bash
   docker-compose logs app
   docker-compose logs mysql
   ```

### Database connection issues

1. Ensure MySQL is healthy:
   ```bash
   docker-compose ps mysql
   ```

2. Check MySQL logs:
   ```bash
   docker-compose logs mysql
   ```

3. Verify database credentials in `.env` file

### Cannot connect to MySQL from host

By default, MySQL is only accessible from within the Docker network. To connect from your host:

```bash
docker exec -it coopcontrol-mysql mysql -uroot -p
```

### Rebuild from scratch

If you encounter persistent issues:

```bash
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d
```

## Environment Variables Reference

| Variable | Description | Default |
|----------|-------------|---------|
| `MYSQL_ROOT_PASSWORD` | MySQL root password | `Plum409r-` |
| `SPRING_DATASOURCE_URL` | Database connection URL | `jdbc:mysql://mysql:3306/courseproject?useSSL=false&serverTimezone=UTC` |
| `SPRING_DATASOURCE_USERNAME` | Database username | `root` |
| `SPRING_DATASOURCE_PASSWORD` | Database password | Same as `MYSQL_ROOT_PASSWORD` |
| `SERVER_PORT` | Application port | `8080` |

## Support

For issues or questions:
- Check the [REST API Documentation](REST_API_DOCUMENTATION.md)
- Review application logs with `docker-compose logs -f app`
- Open an issue on GitHub

## License

See the main README.md for license information.
