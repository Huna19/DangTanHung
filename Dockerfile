# === GIAI ĐOẠN 1: BUILD (Sử dụng Maven và JDK 21) ===
FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app

# 1. Chỉ copy file pom.xml vào trước để tận dụng Docker Cache cho các thư viện
COPY pom.xml .

# 2. Copy toàn bộ thư mục code nguồn src vào máy ảo
COPY src ./src

# 3. Build file jar (Bỏ qua Unit tests để chạy nhanh hơn)
RUN mvn clean package -DskipTests

# === GIAI ĐOẠN 2: RUN (Chỉ dùng JRE 21 giúp nén dung lượng cực nhẹ) ===
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# Lấy file jar đã build thành công từ giai đoạn 1 sang
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
