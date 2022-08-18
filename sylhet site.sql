--Created by Md Atiqur Rahman
clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE or REPLACE PROCEDURE register_user(name IN users.name%TYPE, nid IN users.nid%TYPE)
IS

BEGIN

	INSERT into users values(nid, name, 'Sylhet', ' ', ' ');
	
	EXCEPTION 
		when DUP_VAL_ON_INDEX then
			DBMS_OUTPUT.PUT_LINE('User already exists');
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Other errors');

END register_user;
/

CREATE OR REPLACE PROCEDURE display_user(nid IN users.nid%TYPE)
IS 
	cname vaccine_center.cname%TYPE;
	city vaccine_center.city%TYPE;
	brand vaccine_record.brand%TYPE;
BEGIN
	FOR R IN (SELECT NID, CNAME, CITY, BRAND FROM USERS U JOIN VACCINE_RECORD VR ON U.VID = VR.VID JOIN VACCINE_CENTER VC ON U.CID = VC.CID) LOOP
		IF R.NID = nid THEN
			DBMS_OUTPUT.PUT_LINE(R.CNAME ||', '|| R.CITY ||', '|| R.BRAND);
		END IF;
	END LOOP;
	
END display_user;
/

CREATE OR REPLACE TRIGGER INSERT_MSG
AFTER INSERT 
ON users
FOR EACH ROW
DECLARE
	invalidCityException EXCEPTION;
	random_center_no NUMBER;
	random_vaccine_no NUMBER;
	cnt NUMBER;
	i NUMBER;
	j NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('User created!');
	
	select COUNT(*) into cnt from vaccine_center where city = 'Sylhet';
	j := trunc(dbms_random.value(1, cnt + 1));

	i:= 1;
	FOR R IN (SELECT CID FROM VACCINE_CENTER WHERE city = 'Sylhet') LOOP
		random_center_no := R.CID;
		EXIT WHEN i = j;
		i := i+1;
	END LOOP;
	
	select COUNT(*) into cnt from vaccine_record;
	
	random_vaccine_no := trunc(dbms_random.value(1, cnt + 1));
	--insert into users@server values(:new.nid, :new.name, 'Sylhet', random_vaccine_no_no, random_center_no)
	
END;
/


ACCEPT NAME CHAR PROMPT "Enter your name = "
ACCEPT NID CHAR PROMPT "NID = "
ACCEPT X NUMBER PROMPT "Enter 1 to register, 2 to display = "

DECLARE
	name users.name%TYPE := '&NAME';
	nid users.nid%TYPE := '&NID';
	uInput NUMBER := &X;
BEGIN
	IF uInput = 1 THEN	
		register_user(name, nid);
	ELSIF uInput = 2 THEN
		display_user(nid);
	ELSE
		DBMS_OUTPUT.PUT_LINE('Invalid Input');
	END IF;
END;
/