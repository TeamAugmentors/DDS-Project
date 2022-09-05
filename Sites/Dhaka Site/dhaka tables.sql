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

INSERT into vaccine_center values(1,'Dhaka', 'Mohanagar Institute');
INSERT into vaccine_center values(2,'Dhaka', 'Jahangir Institute');
INSERT into vaccine_center values(3,'Dhaka', 'Popular Diagnostics');

INSERT into vaccine_center_storage values(1, 1, 2);
INSERT into vaccine_center_storage values(1, 2, 20);
INSERT into vaccine_center_storage values(1, 3, 20);
INSERT into vaccine_center_storage values(2, 2, 20);
INSERT into vaccine_center_storage values(3, 3, 20);

commit;