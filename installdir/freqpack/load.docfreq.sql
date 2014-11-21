use XXXDATABASE;

drop table if exists XXXTABLENAME;

create table XXXTABLENAME (
theword VARCHAR(100),
freq MEDIUMINT(5),
philodocid VARCHAR(5),
INDEX (theword),
INDEX (philodocid));

load data local infile "word.freq.doc.srtd" into table XXXTABLENAME
fields terminated by " "
lines terminated by "\n";

