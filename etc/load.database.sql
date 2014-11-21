use philologic;

drop table if exists ...DBNAME...;
 
create table ...DBNAME... (
title VARCHAR(250),
author VARCHAR(250),
date SMALLINT(4),
genre VARCHAR(250),
publisher VARCHAR(250),
pubplace VARCHAR(250),
extent VARCHAR(250),
editor VARCHAR(250),
pubdate VARCHAR(250),
createdate VARCHAR(250),
authordates VARCHAR(250),
keywords VARCHAR(250),
language VARCHAR(250),
collection VARCHAR(250),
gender VARCHAR(250),
sourcenote TEXT,
period VARCHAR(250),
shrtcite VARCHAR(250),
filename VARCHAR(250),
filesize VARCHAR(250),
philodocid SMALLINT(4));
 
load data local infile "...IMAGE.../bibliography" into table ...DBNAME...
fields terminated by "\t"
lines terminated by "\n";
