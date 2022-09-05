CREATE OR REPLACE TRIGGER vcs_server_insert
BEFORE INSERT 
ON vaccine_center_storage
FOR EACH ROW
BEGIN
	insert into vaccine_center_storage@server_site values(:new.cid, :new.vid, :new.amount);
END;
/


CREATE OR REPLACE TRIGGER vcs_server_update
BEFORE UPDATE
ON vaccine_center_storage
FOR EACH ROW
BEGIN
    update vaccine_center_storage@server_site set amount = :new.amount where cid = :new.cid and vid = :new.vid;
END;
/