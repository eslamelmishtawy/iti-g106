FROM maven:3.6.0-jdk-11-slim AS build
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn -f pom.xml clean -DskipTests=true package

FROM openjdk:11-jre-slim
COPY --from=build /tmp/target/*.jar /app.jar

EXPOSE 8000
ENTRYPOINT ["java","-jar","app.jar"]
