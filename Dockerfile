# Giai đoạn build
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build
WORKDIR /app

# PHẢI CÓ DÒNG NÀY: Copy toàn bộ code (bao gồm pom.xml) vào container
COPY . .

# Sau đó mới chạy lệnh build
RUN mvn clean package -DskipTests

# Giai đoạn chạy
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
