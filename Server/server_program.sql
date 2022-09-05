
ACCEPT X NUMBER PROMPT "Enter 1 to display centers and their storage, 2 to display vaccines in mass storage, 3 to add more vaccines to mass storage."
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