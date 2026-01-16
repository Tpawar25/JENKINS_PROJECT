FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY target/indiaproj-1.0.jar  /app/MainClass.jar

ENTRYPOINT ["java","-jar","/app/MainClass.jar"]
