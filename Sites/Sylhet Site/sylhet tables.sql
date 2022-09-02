clear screen;
set linesize 200;

drop table users;

create table users(
nid varchar2(30), 
name varchar2(30), 
city varchar2(30),
vid integer,
cid integer,
        PRIMARY KEY (nid)
);


drop table vaccine_center;

create table vaccine_center(
cid     integer, 
city   varchar2(30), 
cname varchar2(30),
        PRIMARY KEY (cid)
);

INSERT into vaccine_center values(4,'Sylhet', 'Sylhet Institute1');
INSERT into vaccine_center values(5,'Sylhet', 'Sylhet Institute2');
INSERT into vaccine_center values(6,'Sylhet', 'Sylhet Institute3');

commit;