--Created by Md Atiqur Rahman
clear screen;
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE center_display()
IS

BEGIN
	FOR R IN (SELECT * FROM vaccine_center) LOOP
		DBMS_OUTPUT.PUT_LINE(R.CID || ' ' || R.CITY || ' ' || R.CNAME);
	END LOOP;
	
END center_display;
/

CREATE OR REPLACE PROCEDURE vaccine_display()
IS

BEGIN
	FOR R IN (SELECT * FROM vaccine_record) LOOP
		DBMS_OUTPUT.PUT_LINE(R.VID || ' ' || R.BRAND || ' ' || R.AMOUNT);
	END LOOP;
	
END vaccine_display;
/

CREATE OR REPLACE PROCEDURE add_vaccine(ID IN INTEGER, A IN INTEGER)
IS

X INTEGER;

BEGIN
	SELECT AMOUNT INTO X FROM vaccine_record WHERE VID = ID;
	X := X + A;
	UPDATE vaccine_record SET AMOUNT = X;
	
END add_vaccine;
/

CREATE OR REPLACE TRIGGER update_msg
AFTER UPDATE
ON vaccine_record

BEGIN
	DBMS_OUTPUT.PUT_LINE('Updated amount of vaccine successfully');
END;
/

ACCEPT X NUMBER PROMPT "Enter 1 to display centers, 2 to display vaccines, 3 to add more vaccines."
ACCEPT Y NUMBER PROMPT "Enter amount of vaccines : "
ACCEPT Z NUMBER PROMPT "Enter VID: " 

DECLARE
  uInput NUMBER := &X;
  amount NUMBER := &Y;
  vid INTEGER := &Z;
BEGIN

	IF uInput = 1 THEN
		center_display();
	ELSIF uInput = 2 THEN
		vaccine_display();
	ELSIF uInput = 3 THEN
		add_vaccine(vid, amount);
	ELSE
		DBMS_OUTPUT.PUT_LINE('Invalid Input');
	END IF;
	
END;
/