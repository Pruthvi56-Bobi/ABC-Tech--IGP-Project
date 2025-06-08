FROM tomcat:9.0-jdk11

# Remove default Tomcat apps (optional cleanup)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file built by Maven (you’ll build this inside Jenkins)
COPY target/ABCtechnologies-1.0.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
