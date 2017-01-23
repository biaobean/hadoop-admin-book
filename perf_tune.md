# 性能调优

对于磁盘IO密集型：经验值1，1.5，或者顶多2个硬盘对应一个CPU核心  
对于CPU密集型：一个CPU核心对应至少2个硬盘  
通常使用能少的容器/并发，而增大每个的内存更好

#### 小文件问题

增加复制份数，大于3，但小于总共的datanode数目。  
【问题】

## HBase

200个reagion一个服务器

## Kudu

保证Bucket的数目足够多，大于CPU的核数，从而得到更好的并发。  
给Tablets尽量多的内存，从而减少flushing，降低插入压力；同时能让更多的数据保持在cache里，现在策略是LRU\(\)

## Oozie

尽量减少步骤数目，将其合并在一个shell script里。

其他  
使用cgroup来隔离IO，





Hive on MR:

•             /var/log/hadoop/ …   hadoop-&lt;user-running-hadoop&gt;-&lt;daemon&gt;-&lt;hostname&gt;.log/out

•             /user/history/done/2015/01/06/000000

•             Yarn-site.xml; Mapred-site.xml; Hive-site.xml; Hdfs-site.xml



Hive on Spark

·        History log:  hdfs:/user/spark/applicationHistory/application\_xxxxxxxxxxx\_xxxx

·        Yarn Executor log: check directory at  "yarn.nodemanager.remote-app-log-dir"

·Default:  hdfs:/tmp/logs/root/logs. will be deleted after 7 days.



