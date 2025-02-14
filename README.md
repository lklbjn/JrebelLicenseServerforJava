## 宿主机直接安装运行
> 前提是宿主机已经安装好maven和openjdk
```
# 打包
mvn package
# 运行
java -jar JrebelBrainsLicenseServerforJava-1.0-SNAPSHOT-jar-with-dependencies.jar -p 8081
```
## Docker安装
```
# 构建镜像
docker build -t jrebel:1.0.0 .
# 运行
docker run -d --name jrebel -p 8081:8081 --restart always jrebel:1.0.0
```
