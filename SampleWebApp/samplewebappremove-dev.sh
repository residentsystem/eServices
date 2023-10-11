#!/bin/bash
#
###########################################################################################
# File:         tomcatcontainerremove-dev.sh
# Usage:        ./tomcatcontainerremove-dev.sh
#
# Prerequisite: None  
#
# Description:  Remove the tomcat server container and related image.
#
# Author:       Eric Lacroix (Admin) lacroixe@residentsystem.com 
# Organization: Resident System
#
# Created:      2022-10-14
# Version:      1.0
###########################################################################################

# Container Remove - Development

# Remove noexec from home folder if getting permission denied.
## mount -o remount,exec /home

# Pod
tomcat_pod="pod-samplewebapp-dev"

# tomcat Server
tomcat_container="samplewebapp-dev"

# Remove tomcat server container and image
podman stop $tomcat_container
podman rm $tomcat_container
podman image rm $tomcat_container

# Remove pod container
podman pod stop $tomcat_pod
podman pod rm $tomcat_pod