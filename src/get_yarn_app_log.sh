hdfs dfs -ls -R /user/history/done/ |grep job_xxxxxxxxxx_yyyy
2) 使用HDFS命令收集以上输出的两个文件.xml 和 .jhist:


hdfs dfs -copyToLocal HDFS_URL


3) 请尝试用以下命令看是否可以接收到日志：


yarn logs -applicationId application_xxxxxxxx_yyyy -appOwner 
<
user_name
>
>