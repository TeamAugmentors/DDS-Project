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


commit;