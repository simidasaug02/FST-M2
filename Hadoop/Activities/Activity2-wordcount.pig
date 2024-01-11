inputFile = LOAD 'hdfs:///user/simi/input.txt' AS (line:chararray);

words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) as word;
-- Group words By words
grpd = GROUP words BY word;
totalCount = FOREACH grpd GENERATE $0 COUNT(words);



-- Load the input data from HDFS
inputFile = LOAD 'hdfs:///user/simi/input.txt' AS (line:chararray);

words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) as word;
-- Group words By words
grpd = GROUP words BY word;
totalCount = FOREACH grpd GENERATE $0, COUNT($1);
rmf hdfs:///user/simi/Pigoutput
STORE totalCount INTO 'hdfs:///user/simi/Pigoutput';
~                                                    


--$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver 







