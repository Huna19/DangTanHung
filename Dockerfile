# === GIAI ĐOẠN 1: BUILD (dùng Maven + JDK 21) ===
FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy toàn bộ code
COPY . .

# Build jar (bỏ test để build nhanh)
RUN mvn clean package -DskipTests

# === GIAI ĐOẠN 2: RUN (chỉ dùng JRE 21, nhẹ hơn) ===
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Copy file .jar từ giai đoạn build
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

# Chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
