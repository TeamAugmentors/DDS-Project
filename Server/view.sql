create or replace view global_details as 
    select * from vaccine_record natural join vaccine_center_storage natural join vaccine_center;

