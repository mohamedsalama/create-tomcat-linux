#!/bin/bash

##
## should pass 2 parameters with this script
## 1st one is the path for apache tomcat zip file
## 2nd one is the user that will created and give tomcat permissions based on its name
##

echo "== start work on tomcat on location $1 with user $2 =="

#comment this step if your user already created in your linux system
echo "== create group and user with the user $2 =="
# create group and user with the param2
groupadd $2
mkdir /opt/$2-tomcat
useradd -s /bin/nologin -g $2 -d /home/$2 $2

sleep 2

echo "== extract tomcat =="
#extract tomcat with location in param1
tar -zxvf $1 -C /opt/$2-tomcat --strip-components=1 > /dev/null
echo "== extract done =="

sleep 1

echo "== fix tomcat permissions for user $2 =="
#fix permissions for tomcat with parma1
cd /opt/$2-tomcat

chgrp -R $2 conf
chmod g+rwx conf
chmod g+r conf/*
chown -R $2 logs/ temp/ webapps/ work/

chgrp -R $2 bin
chgrp -R $2 lib
chmod g+rwx bin
chmod g+r bin/*

sleep 2

echo "== create tomcat service =="
touch /etc/systemd/system/$2-tomcat.service

echo "
[Unit]
Description=$2 Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/opt/$2-tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/$2-tomcat
Environment=CATALINA_BASE=/opt/$2-tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -XX:MaxDirectMemorySize=512M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/$2-tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

User=$2
Group=$2

[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/$2-tomcat.service

sleep 2

echo "== try start tomcat service $2-tomcat.service located on /etc/systemd/system/$2-tomcat.service =="
systemctl start $2-tomcat.service

sleep 2
echo "check tomcat service status"
systemctl status $2-tomcat.service

echo "== finished create $1 tomcat on /opt/$2-tomcat with user $2 =="
