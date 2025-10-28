FROM openjdk:17-jdk-slim
WORKDIR /app
COPY build/libs/techworld-with-nana-java-react-example.jar app.jar
EXPOSE 7071
ENTRYPOINT ["java", "-jar", "app.jar"]
