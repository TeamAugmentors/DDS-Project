clear screen;
set linesize 200;

drop table users;
drop table vaccine_center;
drop table vaccine_center_storage;

create table users(
nid varchar2(30), 
name varchar2(30), 
city varchar2(30),
vid integer,
cid integer,
        PRIMARY KEY (nid)
);

create table vaccine_center(
cid     integer, 
city   varchar2(30), 
cname varchar2(30),
        PRIMARY KEY (cid)
);

create table vaccine_center_storage(
        cid integer,
        vid integer,
        amount integer
);

INSERT into vaccine_center values(4,'Sylhet', 'Sylhet Institute1');
INSERT into vaccine_center values(5,'Sylhet', 'Sylhet Institute2');
INSERT into vaccine_center values(6,'Sylhet', 'Sylhet Institute3');


INSERT into vaccine_center_storage values(4, 1, 2);
INSERT into vaccine_center_storage values(5, 2, 20);
INSERT into vaccine_center_storage values(6, 3, 20);


commit;