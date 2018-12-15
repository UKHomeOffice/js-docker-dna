FROM java
ADD . /opt/
RUN mkdir /JapserSoft/ && \
tar -xf /opt/apache-tomcat-8.5.35.tar.gz --directory /JapserSoft/ && \
rm /opt/apache-tomcat-8.5.35.tar.gz
ENV CATALINA_HOME=/JapserSoft/apache-tomcat-8.5.35
ENV PATH $CATALINA_HOME/bin:$PATH
EXPOSE 8080
CMD ["catalina.sh","run"]
