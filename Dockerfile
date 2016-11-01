# AlpineLinux Tomcat
#
# VERSION 7.0.69
FROM jimdd/ecbd-jdk7

MAINTAINER Sam Zhao <Sam.X.Zhao@newegg.com>

# Set environment
ENV TOMCAT_MAJOR=7 \
    TOMCAT_VERSION=7.0.69 \
    TOMCAT_HOME=/opt/tomcat \
    CATALINA_HOME=/opt/tomcat \
    CATALINA_OUT=/dev/null

RUN apk upgrade --update && \
    apk add --update curl pwgen && \
    curl -jksSL -o /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    gunzip -c /tmp/apache-tomcat.tar.gz | tar -xf - -C /opt &&\
    curl -jksSL -o /create_tomcat_admin_user.sh https://raw.githubusercontent.com/jz3p/ecbd-tomcat7/master/create_tomcat_admin_user.sh && \
    curl -jksSL -o /run.sh https://raw.githubusercontent.com/jz3p/ecbd-tomcat7/master/run.sh && \
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} ${TOMCAT_HOME} && \
    chmod +x /*.sh  && \
    rm -rf ${TOMCAT_HOME}/webapps/examples ${TOMCAT_HOME}/webapps/docs &&\
    apk del curl && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 8080
CMD ["/run.sh"]

# EOF
