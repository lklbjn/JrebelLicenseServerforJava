# 阶段 1: 使用 Maven 构建应用程序
FROM maven:3.8.6-openjdk-8 AS builder

# 设置工作目录
WORKDIR /app

# 将项目的所有文件拷贝到镜像中
COPY . ./

# 执行 Maven 打包命令（强制更新依赖）
RUN mvn clean package -U -DskipTests

# 阶段 2: 使用 OpenJDK 运行打包好的应用程序
FROM openjdk:8-jdk-alpine

# 设置时区
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

# 暴露端口
EXPOSE 8081

# 拷贝构建好的 JAR 文件到运行镜像中
COPY --from=builder /app/app.jar /app/app.jar

# 启动命令
ENTRYPOINT ["sh", "-c", "java -jar /app/app.jar -p 8081"]
