FROM tomcat
ADD . /opt/
RUN unzip /opt/TIB_js-jrs_7.1.0_bin.zip -d /JapserSoft/  && rm /opt/TIB_js-jrs_7.1.0_bin.zip  && \
mv /JapserSoft/jasperreports-server-pro-7.1.0-bin /JapserSoft/jasperserver-pro && \
mv /opt/default_master.properties /JapserSoft/jasperserver-pro/buildomatic
RUN mv /opt/jasperserver.license /root/
WORKDIR /JapserSoft/jasperserver-pro/buildomatic
RUN ./js-install.sh minimal
EXPOSE 8080
CMD ["catalina.sh","run"]
