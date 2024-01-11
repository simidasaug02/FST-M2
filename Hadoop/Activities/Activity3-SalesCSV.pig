--$ vim sales.csv
--$ hdfs dfs -put ./sales.csv /user/root/

-- Load the CSV file
salesTable = LOAD 'hdfs:///user/root/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- Save result in HDFS folder
STORE CountByCountry INTO 'salesOutput' USING PigStorage('\t');

--$ pig salesCSV.pig
--$ hdfs dfs -cat /user/root/salesOutput/part-r-00000