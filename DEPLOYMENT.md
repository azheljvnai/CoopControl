# Deployment Guide for CoopControl

This guide provides step-by-step instructions for deploying the CoopControl application to various cloud platforms.

## Table of Contents

1. [Deploy to Render (Recommended)](#deploy-to-render-recommended)
2. [Deploy to Railway](#deploy-to-railway)
3. [Deploy to Heroku](#deploy-to-heroku)
4. [Deploy with Docker](#deploy-with-docker)
5. [Environment Variables](#environment-variables)

---

## Deploy to Render (Recommended)

Render is a modern cloud platform that offers free hosting with PostgreSQL databases.

### Prerequisites

- A GitHub account
- A Render account (sign up at https://render.com)

### Deployment Steps

#### Method 1: Using Blueprint (Easiest)

1. **Fork the Repository**
   - Fork this repository to your GitHub account

2. **Sign in to Render**
   - Go to https://render.com and sign in

3. **Create New Blueprint**
   - Click "New" → "Blueprint"
   - Connect your GitHub account if not already connected
   - Select the forked CoopControl repository
   - Click "Connect"

4. **Deploy**
   - Render will detect the `render.yaml` file
   - Click "Apply" to start the deployment
   - Wait 5-10 minutes for the initial deployment

5. **Access Your Application**
   - Once deployed, you'll get a URL like: `https://coopcontrol.onrender.com`
   - Click the URL to access your deployed application

#### Method 2: Manual Setup

1. **Create PostgreSQL Database**
   - In Render dashboard, click "New" → "PostgreSQL"
   - Name: `coopcontrol-db`
   - Region: Choose closest to you
   - Click "Create Database"
   - Note the connection string (Internal Database URL)

2. **Create Web Service**
   - Click "New" → "Web Service"
   - Connect your GitHub repository
   - Configure:
     - **Name**: `coopcontrol`
     - **Runtime**: `Java`
     - **Build Command**: `./mvnw clean package -DskipTests`
     - **Start Command**: `java -Dserver.port=$PORT -Dspring.profiles.active=prod -jar target/CourseProject-0.0.1-SNAPSHOT.jar`

3. **Set Environment Variables**
   - Add these environment variables:
     ```
     SPRING_PROFILES_ACTIVE=prod
     DATABASE_URL=<your-postgres-internal-url>
     JAVA_TOOL_OPTIONS=-Xmx512m
     ```

4. **Deploy**
   - Click "Create Web Service"
   - Wait for deployment to complete

### Post-Deployment

- Your app will be available at the provided Render URL
- Render provides free SSL certificates automatically
- The app will auto-deploy on every push to the main branch

---

## Deploy to Railway

Railway is another excellent platform with free tier and easy deployment.

### Deployment Steps

1. **Sign up at Railway**
   - Go to https://railway.app and sign in with GitHub

2. **Create New Project**
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your CoopControl repository

3. **Add PostgreSQL Database**
   - Click "New" → "Database" → "PostgreSQL"
   - Railway will automatically set `DATABASE_URL` environment variable

4. **Configure Environment Variables**
   - Go to your service settings
   - Add variables:
     ```
     SPRING_PROFILES_ACTIVE=prod
     JAVA_TOOL_OPTIONS=-Xmx512m
     ```

5. **Deploy**
   - Railway will auto-detect the Java app and deploy
   - Click on the deployment to get your public URL

---

## Deploy to Heroku

Heroku is a well-established platform with a free tier (with some limitations).

### Prerequisites

- Heroku account
- Heroku CLI installed

### Deployment Steps

1. **Login to Heroku**
   ```bash
   heroku login
   ```

2. **Create Heroku App**
   ```bash
   heroku create coopcontrol-app
   ```

3. **Add PostgreSQL Database**
   ```bash
   heroku addons:create heroku-postgresql:essential-0
   ```

4. **Set Environment Variables**
   ```bash
   heroku config:set SPRING_PROFILES_ACTIVE=prod
   heroku config:set JAVA_TOOL_OPTIONS=-Xmx512m
   ```

5. **Deploy Using Container**
   ```bash
   heroku container:login
   heroku container:push web
   heroku container:release web
   ```

6. **Or Deploy Using Git**
   ```bash
   git push heroku main
   ```

7. **Open Your App**
   ```bash
   heroku open
   ```

---

## Deploy with Docker

You can deploy the application using Docker to any platform that supports containers.

### Build and Run Locally

1. **Build the Docker Image**
   ```bash
   docker build -t coopcontrol .
   ```

2. **Run with Docker Compose** (Recommended for local testing)
   
   Create a `docker-compose.yml` file:
   ```yaml
   version: '3.8'
   services:
     db:
       image: postgres:15-alpine
       environment:
         POSTGRES_DB: coopcontrol
         POSTGRES_USER: coopcontrol
         POSTGRES_PASSWORD: your_password
       ports:
         - "5432:5432"
       volumes:
         - postgres_data:/var/lib/postgresql/data

     app:
       build: .
       ports:
         - "8080:8080"
       environment:
         SPRING_PROFILES_ACTIVE: prod
         DATABASE_URL: jdbc:postgresql://db:5432/coopcontrol?user=coopcontrol&password=your_password
       depends_on:
         - db

   volumes:
     postgres_data:
   ```

   Then run:
   ```bash
   docker-compose up
   ```

### Deploy to Cloud Platforms

#### Google Cloud Run

```bash
# Build and push to Google Container Registry
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/coopcontrol

# Deploy to Cloud Run
gcloud run deploy coopcontrol \
  --image gcr.io/YOUR_PROJECT_ID/coopcontrol \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --add-cloudsql-instances YOUR_INSTANCE_CONNECTION_NAME \
  --set-env-vars SPRING_PROFILES_ACTIVE=prod,DATABASE_URL=your_connection_string
```

#### AWS Elastic Container Service

```bash
# Push to AWS ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin YOUR_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com
docker tag coopcontrol:latest YOUR_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/coopcontrol:latest
docker push YOUR_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/coopcontrol:latest

# Deploy using ECS CLI or AWS Console
```

---

## Environment Variables

The following environment variables are used in production:

### Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `SPRING_PROFILES_ACTIVE` | Active Spring profile | `prod` |
| `DATABASE_URL` | PostgreSQL connection string | `jdbc:postgresql://host:5432/db?user=user&password=pass` |

### Optional Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Server port | `8080` |
| `JAVA_TOOL_OPTIONS` | JVM options | `-Xmx512m` |

### Database URL Format

For PostgreSQL:
```
jdbc:postgresql://hostname:5432/database_name?user=username&password=password
```

Most cloud platforms provide this in a slightly different format. You may need to convert:

**From**: `postgres://user:pass@host:5432/dbname`

**To**: `jdbc:postgresql://host:5432/dbname?user=user&password=pass`

---

## Troubleshooting

### Application Won't Start

1. Check logs for database connection errors
2. Verify `DATABASE_URL` is correctly formatted
3. Ensure PostgreSQL database is running and accessible
4. Check that `SPRING_PROFILES_ACTIVE=prod` is set

### Out of Memory Errors

1. Increase memory allocation: `JAVA_TOOL_OPTIONS=-Xmx768m`
2. Consider upgrading to a paid tier with more resources

### Database Connection Errors

1. Verify database is running
2. Check firewall/security group settings
3. Ensure connection string includes username and password
4. Try connecting to database directly using psql

### Build Failures

1. Ensure Java 17 is being used
2. Check that `./mvnw` has execute permissions
3. Verify all dependencies can be downloaded

---

## Monitoring and Maintenance

### View Logs

**Render**: Dashboard → Your Service → Logs tab

**Railway**: Dashboard → Your Service → Click on deployment

**Heroku**: 
```bash
heroku logs --tail
```

### Database Backups

Most platforms provide automatic backups:
- **Render**: Automatic daily backups on paid plans
- **Railway**: Configure in database settings
- **Heroku**: `heroku pg:backups:capture`

### Scaling

To handle more traffic, upgrade to paid tiers:
- **Render**: Upgrade to Standard plan ($7/month)
- **Railway**: Pay-as-you-go pricing
- **Heroku**: Upgrade to Hobby plan ($7/month)

---

## Security Considerations

1. **Never commit** database credentials to Git
2. Use **environment variables** for all sensitive data
3. Enable **SSL/HTTPS** (automatically provided by most platforms)
4. Keep **dependencies updated** regularly
5. Monitor **application logs** for suspicious activity

---

## Cost Estimates

### Free Tiers

- **Render**: Free tier available, sleeps after 15 min of inactivity
- **Railway**: $5 free credit per month
- **Heroku**: Free tier available with limitations

### Paid Tiers (Starting prices)

- **Render**: $7/month for always-on service
- **Railway**: ~$5-10/month based on usage
- **Heroku**: $7/month for Hobby tier

---

## Support

For deployment issues:
1. Check platform-specific documentation
2. Review application logs
3. Open an issue in the GitHub repository
4. Contact platform support

---

## Next Steps After Deployment

1. **Test all features** in production
2. **Set up monitoring** and alerts
3. **Configure custom domain** (optional)
4. **Set up CI/CD** for automatic deployments
5. **Create database backups** schedule
6. **Monitor application performance** and optimize as needed

