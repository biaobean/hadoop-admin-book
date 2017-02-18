1） 到HDFS上查找这个job的信息信息是否得到保存

hdfs dfs -ls -R /user/history/done/ \|grep job\_xxxxxxxxxx\_yyyy

2\) 使用HDFS命令收集以上输出的两个文件.xml 和 .jhist:

hdfs dfs -copyToLocal HDFS\_URL

3\) 请尝试用以下命令看是否可以接收到日志：

yarn logs -applicationId application\_xxxxxxxx\_yyyy -appOwner

&lt;

user\_name

&gt;

&gt;

APPID\_logs.txt



https://discuss.pivotal.io/hc/en-us/articles/201925118-How-to-Find-and-Review-Logs-for-Yarn-MapReduce-Jobs



