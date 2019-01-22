FROM centos:7.6.1810

USER root

ENV JAVA_MAJOR_VERSION=8

# /dev/urandom is used as random source, which is prefectly safe
# according to http://www.2uo.de/myths-about-urandom/
RUN yum install -y \
java-1.8.0-openjdk-1.8.0.191.b12-1.el7_6 \
 java-1.8.0-openjdk-devel-1.8.0.191.b12-1.el7_6 \
&& echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/java/jre/lib/security/java.security \
&& yum clean all

ENV JAVA_HOME /etc/alternatives/jre

# Run under user "tomcat" and prepare for be running
# under OpenShift, too
RUN groupadd -r tomcat -g 1000 \
&& useradd -u 1000 -r -g tomcat -m -d /opt/tomcat -s /sbin/nologin tomcat \
&& chmod 755 /opt/tomcat \
&& usermod -g root -G  'id -g tomcat' tomcat

USER tomcat
