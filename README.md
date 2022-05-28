# create-tomcat-linux

Create tomcat instance on opt (You can change it from source code before you run it) folder with fix permissions on tomcat folders based on created user that created on linux servers (tested with ubuntu, parrot, redhat 8, centos7, centos8)

## Usage

First you can download tomcat from this [link](https://downloads.apache.org/tomcat/)
choose your tomcat version and download it. You will find tomcat ```tar.gz``` file located under ```bin``` folder after you choose your tomcat version. To download it you can use ```wget``` command as example below

```
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.63/bin/apache-tomcat-9.0.63.tar.gz
```

To run this script you should run it as below

```bash
sh tomcat-server.sh {path-for-tomcat-zip-file} {user-name} 
```

Example on how to run

```bash
sh tomcat-server.sh apache-tomcat-9.0.63.tar.gz user1
```

```apache-tomcat-9.0.63.tar.gz``` here is just example

## Example output

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

Tomcat service path ```/etc/systemd/system/user1-tomcat.service```

Tomcat path	```/opt/user1-tomcat```

After script run it will try to start tomcat service so if ```8080``` is reserved on your server tomcat won't start in this case and start service will fail because of the port reservation. You will need to change port number in tomcat and try to start service again.

Tomcat server port located on ```/config/server.xml``` file under tomcat folders.

To start service you will need to run below command by root user or you can ```sudo``` it.
```
systemctl start user1-tomcat.service
```

## Tips tricks

Service take any jvm args like below
```
-Xms512M -Xmx1024M -XX:MaxDirectMemorySize=512M -server -XX:+UseParallelGC
```
Lets describe them may be you need to change them or add another on your environment.

For -Xms512M : specifies the initial memory allocation pool.

-Xmx1024M : specifies the maximum memory allocation pool for a Java Virtual Machine (JVM).

-XX:MaxDirectMemorySize=512M : the limit on memory that can be reserved for all Direct Byte Buffers.

-XX:+UseParallelGC : will turn on the parallel garbage collection.


## Environments and versions
Linux environments that this scripts tested with is 

- Ubuntu, Ubuntu server
- Centos 7 & 8
- Parrot
- Redhat 8

and tomcat versions is
- tomcat 7
- tomcat 8
- tomcat 9
- tomcat 10


## Contributing

Contributions are always welcome!

Please make sure to update ```README``` as appropriate.

## License
[Apache 2.0](https://choosealicense.com/licenses/apache-2.0/)
