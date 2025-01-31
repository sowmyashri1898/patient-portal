# Use an official OpenJDK runtime as a parent image
FROM openjdk:21-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/patient-care-0.0.1-SNAPSHOT.jar app.jar

# Copy the wait-for-it script into the container and set executable permissions
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

# Expose the application port
EXPOSE 8080

# Use wait-for-it.sh to wait for other services to be ready and then start the application
ENTRYPOINT ["./wait-for-it.sh", "mysql_container:3306", "--", "java", "-jar", "app.jar"]
