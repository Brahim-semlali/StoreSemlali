FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -q -e -B dependency:go-offline

COPY src ./src
RUN mvn -q -e -B package -DskipTests

FROM tomcat:11.0-jre17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/StoreSemlali-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

ENV SPRING_PROFILES_ACTIVE=prod

