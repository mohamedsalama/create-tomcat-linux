#!/bin/bash

##
## should pass 2 parameters with this script
## 1st one is the path for apache tomcat zip file
## 2nd one is the user that will be created and given tomcat permissions based on its name
##

echo "== start work on tomcat on location $1 with user $2 =="

# Check if the user already exists
if id "$2" &>/dev/null; then
    echo "User $2 already exists."
else
    echo "== create group and user with the user $2 =="
    # Create group and user with the param2
    groupadd $2
    useradd -s /bin/nologin -g $2 -d /home/$2 $2
fi

# Check if the directory exists
if [ ! -d "/opt/$2-tomcat" ]; then
    echo "== Creating directory /opt/$2-tomcat =="
    mkdir -p /opt/$2-tomcat
else
    echo "Directory /opt/$2-tomcat already exists."
fi

sleep 2

echo "== extract tomcat =="
# Extract tomcat with location in param1
if [ -f "$1" ]; then
    tar -zxvf $1 -C /opt/$2-tomcat --strip-components=1 > /dev/null
    echo "== extract done =="
else
    echo "File $1 does not exist. Exiting."
    exit 1
fi

sleep 1

echo "== fix tomcat permissions for user $2 =="
# Fix permissions for tomcat with param2
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
SERVICE_FILE="/etc/systemd/system/$2-tomcat.service"
if [ ! -f "$SERVICE_FILE" ]; then
    touch $SERVICE_FILE
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
" > $SERVICE_FILE
else
    echo "Service file $SERVICE_FILE already exists."
fi

sleep 2

echo "== try start tomcat service $2-tomcat.service located on /etc/systemd/system/$2-tomcat.service =="
systemctl start $2-tomcat.service

sleep 2
echo "check tomcat service status"
systemctl status $2-tomcat.service

echo "== finished creating $1 tomcat on /opt/$2-tomcat with user $2 =="
