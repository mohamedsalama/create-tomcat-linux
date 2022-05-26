# create-tomcat-linux

Create tomcat instance on opt (You can change it from source code before you run it) folder with fix permissions on tomcat folders based on creation user that created on linux servers (tested with ubuntu, parrot, redhat 8, centos7, centos8)

## Usage

First you can download tomcat from this [link](https://downloads.apache.org/tomcat/)
choose your tomcat version and download it

to run this script you should run it as below

```bash
sh tomcat-server.sh {path-for-tomcat-zip-file} {user-name} 
```

example on how to run

```bash
sh tomcat-server.sh apache-tomcat-9.x.xx.tar.gz user1
```

apache-tomcat-9.x.xx.tar.gz here is just sample, this work and tested with tomcat versions from 7 to 10

## example output

```python
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
```

# Informations to know

tomcat service path /etc/systemd/system/user1-tomcat.service

tomcat path	/opt/user1-tomcat

after script run it will try to start tomcat service so if 8080 is reserved on your server tomcat won't start in this case and start service will fail because of the port reservation. you will need to change port number in tomcat and try to start service again.

tomcat server port located on /config/server.xml file under tomcat folders

to start service you will need to run below command by root user or you can sudo it
```
systemctl start user1-tomcat.service
```
## Contributing

Contributions are always welcome!

Please make sure to update tests as appropriate.

## License
[Apache 2.0](https://choosealicense.com/licenses/apache-2.0/)
