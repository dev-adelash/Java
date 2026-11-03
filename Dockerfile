FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /src
COPY java/ ./
RUN mvn -B -DskipTests package
FROM eclipse-temurin:21-jre
WORKDIR /app/java
COPY --from=build /src/target/*.jar /app/service.jar
COPY java/ /app/java/
COPY ui/ /app/ui/
EXPOSE 8000
ENTRYPOINT ["java","-jar","/app/service.jar"]
CMD ["--server.port=8000","--server.address=0.0.0.0","--demo.config=ecommerce-order-and-fulfillment-service-java/project.json"]
