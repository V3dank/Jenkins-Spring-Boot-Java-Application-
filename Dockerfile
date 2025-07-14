## Stage 1: Creating a JAR file
FROM maven:3.9.10-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

## Stage 2: Deploying the JAR file
FROM openjdk:21-jdk-slim
WORKDIR /app
# Ensure the correct jar is being copied
COPY --from=builder /app/target/spring-boot-app-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
