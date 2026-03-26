# === GIAI ĐOẠN 1: BUILD (Dùng Maven và JDK 21) ===
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build

# Tạo thư mục làm việc trong container
WORKDIR /app

# COPY toàn bộ code từ máy Conan vào container (Phải có bước này mới thấy file pom.xml)
COPY . .

# Chạy lệnh build để tạo ra file .jar (Bỏ qua chạy test để build nhanh hơn)
RUN mvn clean package -DskipTests

# === GIAI ĐOẠN 2: RUN (Chỉ dùng JRE 21 để dung lượng nhẹ hơn) ===
FROM eclipse-temurin:21-jre-alpine

# Tạo thư mục chạy ứng dụng
WORKDIR /app

# Copy file .jar đã build xong từ Giai đoạn 1 sang Giai đoạn 2
COPY --from=build /app/target/*.jar app.jar

# Mở cổng 8080 cho ứng dụng
EXPOSE 8080

# Lệnh để chạy ứng dụng Java
ENTRYPOINT ["java", "-jar", "app.jar"]
