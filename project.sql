--Created by Md Atiqur Rahman
clear screen;
SET SERVEROUTPUT ON;
CREATE or REPLACE PROCEDURE register_user(name IN users.name%TYPE, nid IN users.city%TYPE)
IS
	
BEGIN
	
	EXCEPTION 
		when invalidCityException then
			DBMS_OUTPUT.PUT_LINE('Please choose either Dhaka or Sylhet');
		when DUP_VAL_ON_INDEX then
			DBMS_OUTPUT.PUT_LINE('User already exists');
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Other errors');

end;
/

DECLARE
  
BEGIN

	register_user('Atiq', 'Dhaka', '1');
	
END;
/