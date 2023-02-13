FROM registry.access.redhat.com/ubi8/ubi-init
ADD http://almalinux.mirror.liteserver.nl/8.6/AppStream/x86_64/os/Packages/rear-2.6-4.el8.x86_64.rpm rear.rpm
ADD http://almalinux.mirror.liteserver.nl/8.6/BaseOS/x86_64/os/Packages/parted-3.2-39.el8.x86_64.rpm parted.rpm
ADD http://almalinux.mirror.liteserver.nl/8.6/AppStream/x86_64/os/Packages/xorriso-1.4.8-4.el8.x86_64.rpm xorriso.rpm
ADD http://almalinux.mirror.liteserver.nl/8.6/BaseOS/x86_64/os/Packages/dhcp-client-4.3.6-47.el8.x86_64.rpm dhcp-client.rpm
ADD http://almalinux.mirror.liteserver.nl/8.6/BaseOS/x86_64/os/Packages/syslinux-6.04-5.el8.x86_64.rpm syslinux.rpm
ADD rhel-base.repo /etc/yum.repos.d/rhel-base.repo
RUN yum -y install httpd; yum clean all; systemctl enable httpd;
RUN yum -y install rear.rpm parted.rpm xorriso.rpm dhcp-client.rpm syslinux.rpm;
RUN echo "Successful Web Server Test" > /var/www/html/index.html
RUN rear mkbackup;
RUN mkdir /etc/systemd/system/httpd.service.d/; echo -e '[Service]\nRestart=always' > /etc/systemd/system/httpd.service.d/httpd.conf
EXPOSE 80
CMD [ "/sbin/init" ]
