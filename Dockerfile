# The main centos image. May be used as-is to BUILD Tomcat server on CENTOS.
FROM registry.access.redhat.com/ubi9/ubi:latest
LABEL author="Eric Lacroix"

ENV TOMCAT_ROOT /opt/tomcat
ENV JRE_ROOT /opt/jre
ENV TOMCAT_HOME /opt/tomcat/apache-tomcat-9.0.80
ENV JRE_HOME /opt/jre/jre1.8.0_371

# Create directory structure
RUN mkdir ${TOMCAT_ROOT}
RUN mkdir ${JRE_ROOT}

WORKDIR ${TOMCAT_ROOT}

# Extract Apache Tomcat
ADD apache-tomcat-9.0.80.tar.gz .

WORKDIR ${JRE_ROOT}

# Extract Java Runtime Environment
ADD jre-8u371-linux-x64.tar.gz .

#WORKDIR ${TOMCAT_HOME}/webapps

# Get local copy of sample webapp from current directory
#COPY SampleWebApp/SampleWebApp.war .

# Expose server port
EXPOSE 5080
EXPOSE 5443

# Fix permissions to run in OpenShift
USER 0
RUN chgrp -R 0 ${TOMCAT_ROOT} && \
    chmod -R g=u ${TOMCAT_ROOT}

RUN chgrp -R 0 ${JRE_ROOT} && \
    chmod -R g=u ${JRE_ROOT}

# Start tomcat
CMD ["/opt/tomcat/apache-tomcat-9.0.80/bin/catalina.sh", "run"]