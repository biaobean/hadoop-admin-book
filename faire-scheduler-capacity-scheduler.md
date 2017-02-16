

[https://www.quora.com/On-what-basis-do-I-decide-between-Fair-and-Capacity-Scheduler-in-YARN](https://www.quora.com/On-what-basis-do-I-decide-between-Fair-and-Capacity-Scheduler-in-YARN)

Apache YARN的缺省调度器为Capacity Scheduler，但代码质量不高，bug很多。而Fare Scheduler已经实现了所有Capacity Scheduler的功能，因此建议使用Fare Scheduler。Cloudera在现在版本中建议使用Fare Scheduler，并会在CDH6.0以后将Capacity Scheduler删除。（参见[https://www.cloudera.com/documentation/enterprise/release-notes/topics/rg\\_deprecated.html）](https://www.cloudera.com/documentation/enterprise/release-notes/topics/rg\_deprecated.html）)

