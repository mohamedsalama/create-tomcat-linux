# create-tomcat-linux
Create tomcat instance on opt folder with fix permissions on folders based on creation user on linux servers

===
first you can download tomcat from this link https://downloads.apache.org/tomcat/
choose your tomcat version and download it ===

to run this script you should run it as below

sh tomcat-server.sh {path-for-tomcat} {user-name} 

example on how to run ===

sh tomcat-server.sh apache-tomcat-9.x.xx.tar.gz user1

===

example output ===

== start work on tomcat on location apache-tomcat-9.x.xx.tar.gz with user user1 ==
== create group and user with the user user1 ==
== extract tomcat ==
== extract done ==
== fix tomcat permissions for user user1 ==
== create tomcat service ==
== try start tomcat service user1-tomcat.service located on /etc/systemd/system/user1-tomcat.service ==
check tomcat service status
● user1-tomcat.service - user1 Apache Tomcat Web Application Container
   Loaded: loaded (/etc/systemd/system/user1-tomcat.service; disabled; vendor preset: disabled)
   Active: active (running) since Sat 2022-05-14 18:52:25 GMT; 2s ago
  Process: 3395134 ExecStart=/opt/user1-tomcat/bin/startup.sh (code=exited, status=0/SUCCESS)
 Main PID: 3395141 (java)
    Tasks: 32 (limit: 37060)
   Memory: 136.5M
   CGroup: /system.slice/user1-tomcat.service
           └─3395141 /usr/lib/jvm/jre/bin/java -Djava.util.logging.config.file=/opt/user1-tomcat/c>

May 14 18:52:25 instance-20220423-0021 systemd[1]: Starting user1 Apache Tomcat Web Application Co>
May 14 18:52:25 instance-20220423-0021 systemd[1]: Started user1 Apache Tomcat Web Application Con>
== finished create apache-tomcat-9.x.xx.tar.gz tomcat on /opt/user1-tomcat with user user1 ==

===

paths to know

tomcat service path /etc/systemd/system/user1-tomcat.service
tomcat path	/opt/user1-tomcat
