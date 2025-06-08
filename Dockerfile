# Use an official Tomcat image to run the app

FROM tomcat:8.5-jre8



# Remove default webapps to avoid conflicts

RUN rm -rf /usr/local/tomcat/webapps/*



# Copy the built WAR file from the previous stage

COPY --from=build /app/target/ABCtechnologies-1.0.war /usr/local/tomcat/webapps/ROOT.war



# Expose Tomcat port

EXPOSE 8080



# Start Tomcat server

CMD ["catalina.sh", "run"]
