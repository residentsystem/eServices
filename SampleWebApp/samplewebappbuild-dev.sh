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

# Pod Configuration
tomcat_pod="pod-samplewebapp-dev"
tomcat_container="samplewebapp-dev"

http_port_ex=8080
https_port_ex=8443

http_port_in=8080
https_port_in=8443

# Create pod
podman pod create --name $tomcat_pod -p 0.0.0.0:$http_port_ex:$http_port_in -p 0.0.0.0:$https_port_ex:$https_port_in

# Build image
podman build --tag $tomcat_container -f Dockerfile

# Run container
podman run --name $tomcat_container -dt --pod $tomcat_pod localhost/$tomcat_container:latest