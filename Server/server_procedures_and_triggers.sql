--this is the server site
clear screen;
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE center_display
IS

BEGIN
	FOR R IN (SELECT * FROM vaccine_center) LOOP
		DBMS_OUTPUT.PUT_LINE(R.CID || ' ' || R.CITY || ' ' || R.CNAME ||chr(13)||chr(10));
		DBMS_OUTPUT.PUT_LINE(R.CNAME ||' HAS THE FOLLOWING VACCINES:' ||chr(13)||chr(10));

		FOR V IN (SELECT brand, amount FROM vaccine_center_storage vcs join vaccine_record vr on vr.vid = vcs.vid WHERE R.CID = cid) LOOP
			DBMS_OUTPUT.PUT_LINE(V.BRAND || ' ' || V.AMOUNT);
		END LOOP;
		DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||chr(13)||chr(10));
		
	END LOOP;
	
END center_display;
/

CREATE OR REPLACE PROCEDURE vaccine_display
IS

BEGIN
	FOR R IN (SELECT * FROM vaccine_record) LOOP
		DBMS_OUTPUT.PUT_LINE(R.VID || ' ' || R.BRAND);
		FOR V IN (SELECT * FROM vaccine_mass_storage WHERE R.VID = vid) LOOP
			DBMS_OUTPUT.PUT_LINE('Mass storage contains: ' || V.AMOUNT);
		END LOOP;
	END LOOP;
	
END vaccine_display;
/

CREATE OR REPLACE PROCEDURE add_vaccine_to_mass_storage(ID IN INTEGER, A IN INTEGER)
IS

X INTEGER;

BEGIN
	SELECT AMOUNT INTO X FROM vaccine_mass_storage WHERE VID = ID;
	X := X + A;
	UPDATE vaccine_mass_storage SET AMOUNT = X where vid = id;
	
END add_vaccine_to_mass_storage;
/

CREATE OR REPLACE TRIGGER update_msg
AFTER UPDATE
ON vaccine_record

BEGIN
	DBMS_OUTPUT.PUT_LINE('Updated amount of vaccines successfully');
END;
/
