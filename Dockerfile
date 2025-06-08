FROM tomcat:9.0-jdk11

# Remove default apps if you want (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to deploy
COPY myapp.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
