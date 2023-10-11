# The main centos image. May be used as-is to BUILD Tomcat server on CENTOS.
#FROM quay.io/gresident/residentsystem:web-tomcat-dev
FROM quay.io/gresident/eservices:web-tomcat-dev
LABEL author="Eric Lacroix"

ENV TOMCAT_HOME /opt/tomcat/apache-tomcat-9.0.80

WORKDIR ${TOMCAT_HOME}/webapps

# Get local copy of sample webapp from current directory
COPY SampleWebApp.war .

# Expose server port
EXPOSE 8080
EXPOSE 8443

# Fix permissions to run in OpenShift
USER 0
RUN chgrp -R 0 ${TOMCAT_ROOT} && \
    chmod -R g=u ${TOMCAT_ROOT}

RUN chgrp -R 0 ${JRE_ROOT} && \
    chmod -R g=u ${JRE_ROOT}

# Start tomcat
CMD ["/opt/tomcat/apache-tomcat-9.0.80/bin/catalina.sh", "run"]