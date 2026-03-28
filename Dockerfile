# ===== BUILD STAGE =====
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy toàn bộ project (có pom.xml)
COPY . .

# Build project
RUN mvn clean package -DskipTests


# ===== RUN STAGE =====
FROM openjdk:17

WORKDIR /app

# Copy file jar từ stage build
COPY --from=build /app/target/*.jar app.jar

# Chạy app
ENTRYPOINT ["java", "-jar", "app.jar"]
