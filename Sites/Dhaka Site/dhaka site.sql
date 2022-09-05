--dhaka site
clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE or REPLACE PROCEDURE register_user(name IN users.name%TYPE, nid IN users.nid%TYPE)
IS
	random_center_no NUMBER;
	random_vaccine_no NUMBER;
	cnt NUMBER;
	i NUMBER;
	j NUMBER;
	
BEGIN

	select COUNT(*) into cnt from vaccine_center;
	j := trunc(dbms_random.value(1, cnt + 1));
	i:= 1;

	FOR R IN (SELECT CID FROM VACCINE_CENTER) LOOP
		random_center_no := R.CID;
		EXIT WHEN i = j;
		i := i+1;
	END LOOP;
	
	select COUNT(*) into cnt from vaccine_center_storage;
	j := trunc(dbms_random.value(1, cnt + 1));
	i:= 1;
	--write a function for this later
	FOR R IN (SELECT VID FROM vaccine_center_storage) LOOP
		random_vaccine_no := R.VID;
		EXIT WHEN i = j;
		i := i+1;
	END LOOP;

	INSERT into users values(nid, name, 'Dhaka', random_vaccine_no, random_center_no);
	
	EXCEPTION 
		when DUP_VAL_ON_INDEX then
			DBMS_OUTPUT.PUT_LINE('User already exists');

END register_user;
/

CREATE OR REPLACE PROCEDURE display_user(nid IN users.nid%TYPE)
IS 
BEGIN
	dbms_output.put_line('HERE');
	FOR R IN (SELECT NID, CNAME, CITY, BRAND FROM USERS U JOIN vaccine_record@server_site VR ON U.VID = VR.VID JOIN vaccine_center vc on vc.cid = u.cid) LOOP
		IF R.NID = nid THEN
			DBMS_OUTPUT.PUT_LINE(R.CNAME ||', '|| R.CITY ||', '|| R.BRAND);
		END IF;
	END LOOP;
	
END display_user;
/

--make a procedure that requests for more vaccines from server_site

CREATE OR REPLACE PROCEDURE request_vaccines(ID in Number, quantity in number, cid in vaccine_center.cid%TYPE)
IS
	mass_center_quantity NUMBER;
	not_enough_vaccines exception;
BEGIN
	--do a global transaction from vaccine_mass_storage and add it to vaccine_center_storage
	update vaccine_mass_storage@server_site set amount = amount - quantity where vid = ID;
	select amount into mass_center_quantity from vaccine_mass_storage@server_site where vid = ID;

	if (mass_center_quantity > 0) then
		update vaccine_center_storage set amount = amount + quantity where vid = ID and cid = cid;
	ELSE
		update vaccine_mass_storage@server_site set amount = amount + quantity where vid = ID;
		RAISE not_enough_vaccines;
	end if;

	EXCEPTION
		WHEN not_enough_vaccines THEN
			DBMS_OUTPUT.PUT_LINE('Not enough vaccines in mass storage. Registration failed');
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Other errors');


END request_vaccines;
/

CREATE OR REPLACE TRIGGER INSERT_INTO_SERVER
BEFORE INSERT 
ON users
FOR EACH ROW
DECLARE
	--declare a varchar called vaccine brand and center name
	vaccine_brand VARCHAR2(20);
	center_name VARCHAR2(20);
	quantity number(20);
BEGIN
	--reduce the amount of vaccine from the vaccine center storage by 1 
	update vaccine_center_storage set amount = amount - 1 where vid = :new.vid;
	select amount into quantity from vaccine_center_storage where vid = :new.vid and cid = :new.cid;

	--if the quantity falls below 0, request for more vaccines from vaccine_mass_storage@server_site
	IF quantity < 0 THEN
		update vaccine_center_storage set amount = amount + 1 where vid = :new.vid;
		request_vaccines(:new.vid, 10, :new.cid);
		update vaccine_center_storage set amount = amount - 1 where vid = :new.vid;
	END IF;

	insert into users@server_site values(:new.nid, :new.name, 'Dhaka', :new.vid, :new.cid);


	DBMS_OUTPUT.PUT_LINE('User successfully registered! Details are given below:');
	DBMS_OUTPUT.PUT_LINE('');
	DBMS_OUTPUT.PUT_LINE('Name: '||:new.name);
	DBMS_OUTPUT.PUT_LINE('NID: '||:new.nid);
	DBMS_OUTPUT.PUT_LINE('City: '||:new.city);
	--query the vaccine record table to get the brand and show output
	SELECT BRAND INTO vaccine_brand FROM VACCINE_RECORD@server_site WHERE VID = :new.vid;
	DBMS_OUTPUT.PUT_LINE('Vaccine Brand: '||vaccine_brand);

	--query the vaccine center table to get the center name and show output
	SELECT CNAME INTO center_name FROM VACCINE_CENTER WHERE CID = :new.cid;
	DBMS_OUTPUT.PUT_LINE('Center Name: '||center_name);
END;
/