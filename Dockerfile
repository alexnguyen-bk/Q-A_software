## Bước 1: Dùng JDK 25 để chạy ứng dụng
#FROM eclipse-temurin:25-jdk
#
## Bước 2: Tạo thư mục làm việc trong container
#WORKDIR /app
#
## Bước 3: Copy file jar đã build từ máy thật vào container
## Lưu ý: Tên file .jar phải khớp với tên trong thư mục target/
#COPY target/*.jar app.jar
#
## Bước 4: Mở port 8386 để bên ngoài truy cập được
#EXPOSE 8386
#
## Bước 5: Lệnh để chạy ứng dụng
#ENTRYPOINT ["java", "-jar", "app.jar"]
# ===== STAGE 1: Build ứng dụng bằng Maven =====
FROM eclipse-temurin:25-jdk AS builder

WORKDIR /app

# Copy file pom.xml trước (để Docker cache dependencies)
COPY pom.xml .
COPY .mvn/ .mvn/
COPY mvnw .

# Download dependencies (cache layer này nếu pom.xml không đổi)
RUN ./mvnw dependency:go-offline -B

# Copy source code và build
COPY src/ src/
RUN ./mvnw clean package -DskipTests

# ===== STAGE 2: Chạy ứng dụng =====
FROM eclipse-temurin:25-jdk

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8386

ENTRYPOINT ["java", "-jar", "app.jar"]