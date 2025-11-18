# CoopControl - Chicken Coop Management System

A comprehensive web-based management system for chicken coops, built with Spring Boot and featuring inventory management, health tracking, financial reporting, and more.

## Screenshots

<img width="1882" height="921" alt="Dashboard" src="https://github.com/user-attachments/assets/3e1a3a2b-53aa-4398-8e32-d681c67115bd" />
<img width="1908" height="926" alt="Flocks Management" src="https://github.com/user-attachments/assets/2c046612-3c4d-4647-897e-5d972e3e2700" />
<img width="1903" height="925" alt="Inventory" src="https://github.com/user-attachments/assets/9eb7e5f5-ae72-4b74-b7af-352a417b385e" />
<img width="1861" height="882" alt="Financials" src="https://github.com/user-attachments/assets/977f89e1-abc2-4e45-9652-c49cfd2662f4" />
<img width="1871" height="898" alt="Reports" src="https://github.com/user-attachments/assets/6e816c99-07a6-491a-a6f2-7c6a8bf2c5db" />

## Features

- 🐔 **Flock Management**: Track chicken flocks, breeds, and bird counts
- 📦 **Inventory Management**: Manage feed, medicine, and supplies
- 💰 **Financial Tracking**: Record sales and expenses with detailed reporting
- 📊 **Reports & Analytics**: Comprehensive dashboard and financial summaries
- 🏥 **Health Records**: Monitor flock health and mortality
- 🥚 **Egg Production**: Track daily egg production
- 🔌 **REST API**: Full RESTful API for all operations

## Technology Stack

- **Backend**: Spring Boot 3.5.7
- **Database**: MySQL (development), PostgreSQL (production)
- **Template Engine**: FreeMarker
- **Build Tool**: Maven
- **Java Version**: 17

## Quick Start (Local Development)

### Prerequisites

- Java 17 or higher
- Maven 3.6+
- MySQL 8.0+

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/azheljvnai/CoopControl.git
   cd CoopControl
   ```

2. Create a MySQL database:
   ```sql
   CREATE DATABASE courseproject;
   ```

3. Update `src/main/resources/application.properties` with your MySQL credentials:
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/courseproject?useSSL=false&serverTimezone=UTC
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   ```

4. Build and run the application:
   ```bash
   ./mvnw spring-boot:run
   ```

5. Access the application at `http://localhost:8080`

## Deployment

### Deploy to Render (Recommended)

Render is a cloud platform that provides free hosting for web applications with PostgreSQL databases.

#### Option 1: One-Click Deploy

1. Fork this repository to your GitHub account
2. Sign up for a free account at [Render](https://render.com)
3. From your Render dashboard, click "New" → "Blueprint"
4. Connect your GitHub account and select the CoopControl repository
5. Render will automatically detect the `render.yaml` file and deploy your application
6. Wait for the deployment to complete (5-10 minutes)
7. Your app will be available at `https://coopcontrol.onrender.com` (or similar)

#### Option 2: Manual Setup

1. Create a new PostgreSQL database on Render
2. Create a new Web Service on Render
3. Configure the following settings:
   - **Build Command**: `./mvnw clean package -DskipTests`
   - **Start Command**: `java -Dserver.port=$PORT -Dspring.profiles.active=prod -jar target/CourseProject-0.0.1-SNAPSHOT.jar`
   - **Environment Variables**:
     - `SPRING_PROFILES_ACTIVE=prod`
     - `DATABASE_URL=<your-postgres-connection-string>`
     - `JAVA_TOOL_OPTIONS=-Xmx512m`

### Deploy with Docker

1. Build the Docker image:
   ```bash
   docker build -t coopcontrol .
   ```

2. Run the container:
   ```bash
   docker run -p 8080:8080 \
     -e SPRING_PROFILES_ACTIVE=prod \
     -e DATABASE_URL=<your-postgres-connection-string> \
     coopcontrol
   ```

### Deploy to Other Platforms

The application can also be deployed to:
- **Heroku**: Use the included `Dockerfile` with Heroku's container registry
- **Railway**: Connect your GitHub repository and Railway will auto-detect the Java app
- **AWS Elastic Beanstalk**: Package as a JAR and deploy
- **Google Cloud Platform**: Use App Engine or Cloud Run
- **Azure**: Use App Service

## API Documentation

The application includes comprehensive REST API documentation. See [REST_API_DOCUMENTATION.md](REST_API_DOCUMENTATION.md) for details.

When the application is running, you can also access interactive API documentation at:
- Swagger UI: `http://localhost:8080/swagger-ui.html`
- OpenAPI spec: `http://localhost:8080/v3/api-docs`

## Environment Profiles

The application supports two profiles:

- **default** (development): Uses MySQL database configured in `application.properties`
- **prod** (production): Uses PostgreSQL database configured in `application-prod.properties`

To run with production profile locally:
```bash
./mvnw spring-boot:run -Dspring-boot.run.profiles=prod
```

## Project Structure

```
src/
├── main/
│   ├── java/com/grp10/CourseProject/
│   │   ├── controller/      # REST and web controllers
│   │   ├── model/           # JPA entities
│   │   ├── repository/      # Data repositories
│   │   ├── service/         # Business logic
│   │   └── exception/       # Custom exceptions
│   └── resources/
│       ├── static/          # CSS, JS, images
│       ├── templates/       # FreeMarker templates
│       ├── application.properties
│       └── application-prod.properties
└── test/                    # Unit and integration tests
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source and available under the MIT License.

## Support

For issues, questions, or contributions, please open an issue in the GitHub repository.
