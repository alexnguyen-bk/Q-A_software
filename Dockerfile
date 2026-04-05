# Bước 1: Dùng JDK 25 để chạy ứng dụng
FROM eclipse-temurin:25-jdk

# Bước 2: Tạo thư mục làm việc trong container
WORKDIR /app

# Bước 3: Copy file jar đã build từ máy thật vào container
# Lưu ý: Tên file .jar phải khớp với tên trong thư mục target/
COPY target/*.jar app.jar

# Bước 4: Mở port 8386 để bên ngoài truy cập được
EXPOSE 8386

# Bước 5: Lệnh để chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]