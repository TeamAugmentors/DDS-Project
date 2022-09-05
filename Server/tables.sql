clear screen;
set linesize 200;

--delete existing table
drop table vaccine_record;
drop table vaccine_center;
drop table vaccine_mass_storage;
drop table vaccine_center_storage;
drop table users;

--Create vaccine, vaccine_record

create table vaccine_record(
vid integer,
brand varchar2(30),
        PRIMARY KEY (vid)
);

create table vaccine_mass_storage(
        vid integer,
        amount integer
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

create table users(
nid varchar2(30), 
name varchar2(30), 
city varchar2(30),
vid integer,
cid integer,
        PRIMARY KEY (nid)
		--FOREIGN KEY(cid) REFERENCES vaccine_center(cid), 
		--FOREIGN KEY(vid) REFERENCES vaccine_record(vid)
);

insert into users values('123', 'John', 'Dhaka', 1, 1);


-----insert into vaccine_center----------
INSERT into vaccine_center values(1,'Dhaka', 'Mohanagar Institute');
INSERT into vaccine_center values(2,'Dhaka', 'Jahangir Institute');
INSERT into vaccine_center values(3,'Dhaka', 'Popular Diagnostics');

INSERT into vaccine_center values(4,'Sylhet', 'Sylhet Institute1');
INSERT into vaccine_center values(5,'Sylhet', 'Sylhet Institute2');
INSERT into vaccine_center values(6,'Sylhet', 'Sylhet Institute3');


-----insert into vaccine_record----------
INSERT into vaccine_record values(1, 'AstraZeneca');
INSERT into vaccine_record values(2, 'Pfizer');
INSERT into vaccine_record values(3, 'Sputnik V');

-- insert into vaccine_center_storage
INSERT into vaccine_center_storage values(1, 1, 2);
INSERT into vaccine_center_storage values(1, 2, 20);
INSERT into vaccine_center_storage values(1, 3, 20);
INSERT into vaccine_center_storage values(2, 2, 20);
INSERT into vaccine_center_storage values(3, 3, 20);

INSERT into vaccine_center_storage values(4, 1, 2);
INSERT into vaccine_center_storage values(5, 2, 20);
INSERT into vaccine_center_storage values(6, 3, 20);

-- insert into vaccince_mass_storage 
INSERT into vaccine_mass_storage values(1, 200);
INSERT into vaccine_mass_storage values(2, 300);
INSERT into vaccine_mass_storage values(3, 400);

commit;

