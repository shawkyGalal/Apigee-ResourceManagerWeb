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
RUN git clone https://github.com/shawkyGalal/Apigee-ResourceManager.git 
WORKDIR /temp/Apigee-ResourceManager
RUN git pull 
RUN mvn clean install -DskipTests

WORKDIR /temp
RUN git clone https://github.com/shawkyGalal/Apigee-ResourceManagerWeb.git
 
# Build ( Package )  application with maven 
WORKDIR /temp/Apigee-ResourceManagerWeb
RUN git pull
RUN mvn package -DskipTests 
RUN cp -r /temp/Apigee-ResourceManagerWeb/target/*.war /usr/local/tomcat/webapps

# ...

# The rest of your Dockerfile
# ...

