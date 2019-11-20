# Hadoop Configuration

## Conceptions
Hadoop Distributed File System (HDFS)
* run across clustered and low-cost machines

Namenode | Datanode
:-:|:-:
master|slave
manage files and meta data | storage data, read and write data

## Environment Setup
1. Set up server hosts, and make sure any server can ping successfully to each others. 

2. Make sure `nameserver` (master) can login any `datanode` (slaves) including master itself using `ssh`.

3. Install `JDK` for all servers. 

4. Install `Hadoop` for all servers (you can install `Hadoop` for master and then copy the folder to all salves).

5. Hadoop configuration
```sh
export HADOOP_HOME=path/to/hadoop
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
export CLASSPATH=$CLASSPATH:${HADOOP_HOME}/lib:${HADOOP_HOME}/bin:${HADOOP_HOME}
export HADOOP_CLASSPATH=$CLASSPATH
export HADOOP_MAPRED_HOME=${HADOOP_HOME}  
export HADOOP_COMMON_HOME=${HADOOP_HOME}  
export HADOOP_HDFS_HOME=${HADOOP_HOME}  
export YARN_HOME=${HADOOP_HOME}  
export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/natvie    
export HADOOP_OPTS="-Djava.library.path=${HADOOP_HOME}/lib:${HADOOP_HOME}/lib/native" 
```

### Hadoop Configuration Setup 
All configuration files are in `$HADOOP_HOME/etc/hadoop/`

1.  `hadoop-env.sh` 
```sh
export JAVA_HOME=/home/zhfeing/apps/jdk1.8.0_231
```

2. `core-site.xml`
```xml
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://zhfeing-vipa:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/media/Data/project/pydoop-learn/hadoop_tmp</value>
    </property>
</configuration>
```

3. `hdfs-site.xml`
```xml
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>2</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>/home/zhfeing/hadoop-test/hadoop_namenode</value>
    </property>

    <property>
        <name>dfs.datanode.data.dir</name>
        <value>/home/zhfeing/hadoop-test/hadoop_datanode</value>
    </property>
    <property>
        <name>dfs.permissions</name>
        <value>false</value>
    </property>
</configuration>
```

4. `mapred-site.xml`
```xml
<configuration>
    <!--property>  
        <name>mapreduce.framework.name</name>  
        <value>yarn</value>  
    </property-->
</configuration>
```

5. `workers`
file with server host names
```
vipa-205
vipa-206
vipa-207
```

> [Official setup](https://hadoop.apache.org/docs/r3.2.1/hadoop-project-dist/hadoop-common/ClusterSetup.html)

## Auto Update Config
```sh
#!/bin/sh
# copy to local
cp *.xml workers /home/zhfeing/apps/hadoop-3.2.1/etc/hadoop/
scp *.xml workers vipa-205:/home/zhfeing/apps/hadoop-3.2.1/etc/hadoop/
scp *.xml workers vipa-206:/home/zhfeing/apps/hadoop-3.2.1/etc/hadoop/
scp *.xml workers vipa-207:/home/zhfeing/apps/hadoop-3.2.1/etc/hadoop/
```