# Use an official Tomcat runtime as a parent image
FROM tomcat:latest

# Install git
RUN apt-get update && apt-get install -y git
RUN apt-get install -y maven

# Set the working directory
# move the manager app to the webapp folder 
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps

WORKDIR /temp
# Clone your GitHub repository
RUN git clone https://github.com/shawkyGalal/Apigee-ResourceManagerWeb.git 

# RUN mkdir /usr/local/tomcat/webapps/ResourceManagerWeb
# RUN cp -r /temp/WebContent/* /usr/local/tomcat/webapps/ResourceManagerWeb


# Build your application (if necessary)

WORKDIR /temp/ResourceManagerWeb
mvn clean package
RUN jar -cvf /usr/local/tomcat/webapps/ResourceManagerWeb.war *
# ...

# The rest of your Dockerfile
# ...

