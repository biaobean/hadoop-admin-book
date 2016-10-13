# 如何在Hadoop上支持PL/SQL

介绍一个基于Apache协议开源的工具——[HPL/SQL](http://www.hplsql.org/)，已经在Hive 2.0中被引入，为Hive、SparkSQL等SQL-on-Hadoop产品、NoSQL和RDBMS提供了过程式SQL语言支持。

HPL/SQL语言兼容80%以上的Oracle PL/SQL语法，并很大程度上与ANSI/ISO SQL/PSM（如IBM DB2，MySQL和Teradata等），Teradata的BTEQ，PostgreSQL的PL/ pgSQL（来自Netezza公司），Transact-SQL（来自微软的SQL Server和Sybase）。这不仅使用户能充分利用现有的SQL/DWH技能和熟悉的方式来实现Hadoop的数据仓库解决方案，也有利于现有业务逻辑的Hadoop迁移。

HPL/SQL的函数（Function）以及过程（Procedure）使用非常简单。

## 配置环境

将下面代码写入.plhqlrc文件，并将其以及相应jar文件放入Hive环境变量以及配置路径中。

```sql
ADD JAR /home/pl/plhql.jar;
ADD JAR /home/pl/antlr-runtime-4.4.jar;

ADD FILE /home/pl/plhql-site.xml;
ADD FILE /home/pl/plhqlrc;

CREATE TEMPORARY FUNCTION plhql AS 'org.plhql.Udf';
```

## 函数
将函数或过程在脚本文件中声明：

```sql
CREATE FUNCTION hello(text STRING)
 RETURNS STRING
BEGIN
  RETURN 'Hello, ' || text || '!';
END;
```

可以用SQL测试：

```sql
-- Invoke the function
PRINT hello('world');
```

一旦定义以后，函数就可以被看作为一个内建的函数，能被任何的HPL/SQL或则HQL表达式直接使用，而过程可以通过CALL语句调用。

如在Hive的CLI环境中直接可运行下面语句：

```sql
SELECT plhql('hello(:1)', name) FROM users;
```

或在HPL/SQL的CLI环境中直接运行下面语句：

```sql
SELECT hello(name) FROM users;
```

HPL/SQL的CLI会自动将所调用的用户函数或存储过程放入分布式缓存（Distributed Cache），然后将其注册为Hive UDF，并自动改动SQL语句中的函数调用。

## 存储过程

```sql
CREATE PROCEDURE set_message(IN name STRING, OUT result STRING)
BEGIN
  SET result = 'Hello, ' || name || '!';
END;

-- Call the procedure and print the results
DECLEAR str STRING;
CALL set_message('world', str);
PRINT str;
```

## 在CDH中的安装
在通过parcel包方式安装的CDH环境中，按以下步骤安装HPL/SQL：

【第一步】下载jar包解压，编辑hplsql文件为可执行

【第二步】 配置CLASSPATH

打开hplsql文件，删除所有类似以下的export
```
export "HADOOP_CLASSPATH=..."
```

加入以下行:

```
#my add for support CDH.
hadoopHome='/opt/cloudera/parcels/CDH/lib'
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hadoop/*"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hadoop/lib/*"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/etc/hadoop/conf"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hadoop-mapreduce/*"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hadoop-mapreduce/lib/*"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hadoop-hdfs/*"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hadoop-hdfs/lib/*"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hadoop-yarn/*"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hadoop-yarn/lib/*"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hive/lib/*"
export  "HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$hadoopHome/hive/conf"
```

【第三步】添加环境变量，加入hplsql执行文件路径

```
export PATH=$PATH:(项目路径)
```

【第四步】启动服务

```
hiveserver2
```

【第五步】测试是否安装成功

```
hplsql -e "CURRENT_DATE+1"
```