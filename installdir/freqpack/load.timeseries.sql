use XXXDATABASE;

drop table if exists XXXTABLENAME;

create table XXXTABLENAME (
theword VARCHAR(100),
theyear SMALLINT(4),
freq MEDIUMINT(6),
thesortword VARCHAR(100),
INDEX (theword),
INDEX (theyear));

load data local infile "word.year.freq.srtd" into table XXXTABLENAME
fields terminated by " "
lines terminated by "\n";

