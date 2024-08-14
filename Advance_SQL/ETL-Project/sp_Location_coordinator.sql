CREATE OR REPLACE PROCEDURE sp_location_coordinator
AS 
  v_id RAW(16);
  v_is_primary NUMBER(1,0);
  v_location_id RAW(16);
  v_user_id RAW(16);
  v_created_by RAW(16);
  v_updated_by RAW(16);
  v_first BOOLEAN := TRUE;
  v_region VARCHAR2(255);  
  v_coordinator VARCHAR2(255); 

  CURSOR src_cursor IS 
    SELECT region, coordinators 
    FROM src_centers;

BEGIN
  v_created_by := SYS_GUID();
  v_updated_by := SYS_GUID();

  OPEN src_cursor;
  LOOP 
    FETCH src_cursor INTO v_region, v_coordinator;
    EXIT WHEN src_cursor%NOTFOUND;

    BEGIN 
      IF v_first THEN 
        v_is_primary := 1;
        v_first := FALSE;
      ELSE
        v_is_primary := 0;
      END IF;

      BEGIN 
        SELECT id INTO v_location_id
        FROM target_location 
        WHERE name = v_region;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_location_id := NULL;  
      END;

      BEGIN
        SELECT id INTO v_user_id
        FROM target_user
        WHERE username = v_coordinator--- nedded to check what to compare here
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_user_id := NULL; 
      END;
      
      v_id :=SYS_GUID();
     insert into target_location_coordinator(id,is_primary,location_id,user_id,created_by,updated_by)
     values(v_id,v_is_primary,v_lccation_id,v_user_id,v_created_by,v_updated_by)

    END;
  END LOOP;
  CLOSE src_cursor;
END;
/


select *
from target_users;
