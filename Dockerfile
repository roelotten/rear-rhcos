FROM registry.access.redhat.com/ubi8/ubi-init
ADD rear-2.6-4.el8.x86_64.rpm
RUN yum -y install httpd; yum clean all; systemctl enable httpd;
RUN yum -y install rear-2.6-4.el8.x86_64;
RUN echo "Successful Web Server Test" > /var/www/html/index.html
RUN rear mkbackup;
RUN mkdir /etc/systemd/system/httpd.service.d/; echo -e '[Service]\nRestart=always' > /etc/systemd/system/httpd.service.d/httpd.conf
EXPOSE 80
CMD [ "/sbin/init" ]
