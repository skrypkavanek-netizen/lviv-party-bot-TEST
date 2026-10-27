FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Копіюємо pom.xml та створюємо папку src, якщо Main.java в корені
COPY pom.xml .
COPY Main.java ./src/main/java/org/example/Main.java

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/LvivPartyBot-1.0-SNAPSHOT-jar-with-dependencies.jar app.jar
CMD ["java", "-jar", "app.jar"]
