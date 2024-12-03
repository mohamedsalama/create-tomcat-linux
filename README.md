
# create-tomcat-linux

Create a Tomcat instance in the `/opt` directory (modifiable from the source code) with proper permissions for Tomcat folders based on a user created on Linux servers. This script has been tested with Ubuntu, Parrot, Red Hat 8, CentOS 7, and CentOS 8.

## Updates

- **User check**: The script now checks if the specified user exists before creating it.
- **Directory check**: The script verifies if the necessary directories exist before attempting to create them.
- **File validation**: The script checks if the Tomcat zip file exists before proceeding.

## Usage

First, download Tomcat from this [link](https://downloads.apache.org/tomcat/). Choose your preferred Tomcat version and download it. You will find the Tomcat `.tar.gz` file located under the `bin` folder for the selected version. To download, you can use the `wget` command, as shown below:

```bash
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.63/bin/apache-tomcat-9.0.63.tar.gz
```

To run this script, use the following command:

```bash
sh tomcat-server.sh {path-for-tomcat-zip-file} {user-name}
```

Example:

```bash
sh tomcat-server.sh apache-tomcat-9.0.63.tar.gz user1
```

Here, `apache-tomcat-9.0.63.tar.gz` is just an example.

## Example Output

```bash
== start work on tomcat on location apache-tomcat-9.x.xx.tar.gz with user user1 ==
== User user1 already exists. Skipping creation. ==
== Directory /opt/user1-tomcat already exists. Skipping creation. ==
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
== finished creating apache-tomcat-9.x.xx.tar.gz tomcat on /opt/user1-tomcat with user user1 ==
```

## Informations to Know

- **Tomcat service path**: `/etc/systemd/system/user1-tomcat.service`
- **Tomcat path**: `/opt/user1-tomcat`

After the script runs, it will attempt to start the Tomcat service. If port `8080` is reserved on your server, the service will fail to start. To resolve this, change the port number in Tomcat's `server.xml` configuration file.

Tomcat server port is located in the `config/server.xml` file under Tomcat folders.

To start the service, run the following command as a root user or with `sudo`:

```bash
systemctl start user1-tomcat.service
```

## Tips and Tricks

The service accepts JVM arguments like the following:

```
-Xms512M -Xmx1024M -XX:MaxDirectMemorySize=512M -server -XX:+UseParallelGC
```

Descriptions of these options:

- `-Xms512M`: Specifies the initial memory allocation pool.
- `-Xmx1024M`: Specifies the maximum memory allocation pool for a Java Virtual Machine (JVM).
- `-XX:MaxDirectMemorySize=512M`: Limits memory reserved for all Direct Byte Buffers.
- `-XX:+UseParallelGC`: Enables parallel garbage collection.

## Environments and Versions

### Tested Linux Environments:

- Ubuntu, Ubuntu Server
- CentOS 7 & 8
- Parrot Sec
- Enterprise Red Hat 8
- Debian
- AlmaLinux 9

### Tested Tomcat Versions:

- Tomcat 7
- Tomcat 8
- Tomcat 9
- Tomcat 10
- Tomcat 11

## Contributing

Contributions are always welcome! Please make sure to update the `README` as appropriate.

## License

[Apache 2.0](https://choosealicense.com/licenses/apache-2.0/)
