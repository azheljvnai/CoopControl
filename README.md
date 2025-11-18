# CoopControl

A comprehensive poultry farm management system built with Spring Boot.

<img width="1882" height="921" alt="image" src="https://github.com/user-attachments/assets/3e1a3a2b-53aa-4398-8e32-d681c67115bd" />
<img width="1908" height="926" alt="image" src="https://github.com/user-attachments/assets/2c046612-3c4d-4647-897e-5d972e3e2700" />
<img width="1903" height="925" alt="image" src="https://github.com/user-attachments/assets/9eb7e5f5-ae72-4b74-b7af-352a417b385e" />
<img width="1861" height="882" alt="image" src="https://github.com/user-attachments/assets/977f89e1-abc2-4e45-9652-c49cfd2662f4" />
<img width="1871" height="898" alt="image" src="https://github.com/user-attachments/assets/6e816c99-07a6-491a-a6f2-7c6a8bf2c5db" />

## Features

- **Flock Management**: Track and manage poultry flocks
- **Egg Production**: Monitor daily egg production
- **Health Records**: Maintain health records and medical history
- **Mortality Tracking**: Record and analyze mortality data
- **Feed Management**: Track feed consumption and inventory
- **Medicine Management**: Manage medicine inventory and usage
- **Sales Tracking**: Record and monitor sales transactions
- **Expense Management**: Track operational expenses
- **Supply Management**: Manage supplies and inventory
- **Financial Reports**: Generate financial summaries and reports

## Tech Stack

- **Backend**: Spring Boot 3.5.7
- **Database**: MySQL 8.0
- **ORM**: Spring Data JPA / Hibernate
- **Template Engine**: FreeMarker
- **API Documentation**: SpringDoc OpenAPI (Swagger)
- **Build Tool**: Maven
- **Java Version**: 17

## Quick Deployment

### Using Docker (Recommended)

```bash
# Clone the repository
git clone https://github.com/azheljvnai/CoopControl.git
cd CoopControl

# Run automated deployment
./deploy.sh
```

The application will be available at:
- **Web Application**: http://localhost:8080
- **API Documentation**: http://localhost:8080/swagger-ui.html

For detailed deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md).

### Manual Setup

1. **Prerequisites**:
   - Java 17 or later
   - MySQL 8.0 or later
   - Maven 3.6 or later

2. **Database Setup**:
   ```sql
   CREATE DATABASE courseproject;
   ```

3. **Configuration**:
   Edit `src/main/resources/application.properties` with your database credentials.

4. **Build and Run**:
   ```bash
   ./mvnw clean package
   java -jar target/CourseProject-0.0.1-SNAPSHOT.jar
   ```

## API Documentation

Once the application is running, access the interactive API documentation at:
- Swagger UI: http://localhost:8080/swagger-ui.html
- OpenAPI JSON: http://localhost:8080/v3/api-docs

See [REST_API_DOCUMENTATION.md](REST_API_DOCUMENTATION.md) for detailed API documentation.

## Development

### Running Tests

```bash
./mvnw test
```

### Building

```bash
./mvnw clean package
```

### Running Locally

```bash
./mvnw spring-boot:run
```

## Deployment Options

- **Docker Compose**: For local/development deployment
- **Kubernetes**: For production deployment (see `kubernetes/` directory)
- **Standalone JAR**: For traditional deployment

See [DEPLOYMENT.md](DEPLOYMENT.md) for comprehensive deployment instructions.

## License

See LICENSE file for details.
