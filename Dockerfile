# Giai đoạn 1: Build bằng Maven
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build
WORKDIR /app

# COPY TOÀN BỘ CODE VÀO ĐÂY (Đây là dòng quan trọng nhất)
COPY . .

# Chạy lệnh build (Đã có file pom.xml nên sẽ không lỗi nữa)
RUN mvn clean package -DskipTests

# Giai đoạn 2: Chạy ứng dụng
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
