#!/bin/bash
#
###########################################################################################
# File:         tomcatcontainerbuild-dev.sh
# Usage:        ./tomcatcontainerbuild-dev.sh
#
# Prerequisite: None  
#
# Description:  Build and configure the tomcat server container.
#
# Author:       Eric Lacroix (Admin) lacroixe@residentsystem.com 
# Organization: Resident System
#
# Created:      2022-10-14
# Version:      1.0
###########################################################################################

# Tomcat Container Build - Development

apache="apache-tomcat-9.0.80.tar.gz"
jre="jre-8u371-linux-x64.tar.gz"

# Pod Configuration
tomcat_pod="pod-web-tomcat-dev"
tomcat_container="web-tomcat-dev"

http_port_ex=5080
https_port_ex=5443

http_port_in=8080
https_port_in=8443

# Copy files to build Tomcat
cp ../$apache .
cp ../$jre .

# Create pod
podman pod create --name $tomcat_pod -p 0.0.0.0:$http_port_ex:$http_port_in -p 0.0.0.0:$https_port_ex:$https_port_in

# Build image
podman build --tag $tomcat_container -f Dockerfile

# Run container
podman run --name $tomcat_container -dt --pod $tomcat_pod localhost/$tomcat_container:latest

# Get container Id
tomcat_dev_id=$(podman image inspect --format '{{ .Id }}' $tomcat_container)

# Updload image to repository
podman login quay.io
podman tag $tomcat_dev_id web-tomcat:web-tomcat-dev
#podman push web-tomcat:$tomcat_container quay.io/gresident/residentsystem:$tomcat_container
podman push web-tomcat:$tomcat_container quay.io/gresident/eservices:$tomcat_container

echo ""
echo $tomcat_container "container ID: " $tomcat_dev_id

# Remove the files when done
rm $apache
rm $jre