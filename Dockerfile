# AlpineLinux Tomcat
#
# VERSION 7.0.69
FROM docker.neg/ec2/jpf-jdk:1.7.0_80

MAINTAINER Jim Zhang <jim.d.zhang@newegg.com>

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
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} ${TOMCAT_HOME} && \
    rm -rf ${TOMCAT_HOME}/webapps/examples ${TOMCAT_HOME}/webapps/docs &&\
    apk del curl && \
    rm -rf /tmp/* /var/cache/apk/*

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 8080
CMD ["/run.sh"]

# EOF
