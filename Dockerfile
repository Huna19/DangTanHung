# Giai đoạn 1: Build ứng dụng bằng Maven và JDK 21
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build
WORKDIR /app
# Copy file cấu hình và mã nguồn vào image
COPY pom.xml .
COPY src ./src
# Build ra file .jar (bỏ qua chạy thử test để tiết kiệm thời gian)
RUN mvn clean package -DskipTests

# Giai đoạn 2: Chạy ứng dụng với JRE 21 (cho nhẹ image)
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Lấy file jar đã build từ giai đoạn 1 sang
COPY --from=build /app/target/*.jar app.jar
# Lệnh khởi chạy ứng dụng
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
