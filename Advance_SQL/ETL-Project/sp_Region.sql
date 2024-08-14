
CREATE OR REPLACE PROCEDURE sp_src_regions_target_regions AS
  v_id RAW(16);
  v_name src_regions.region_name%TYPE;
  v_description src_regions.region_name%TYPE; -- Assuming description type matches src_regions
  v_created_by RAW(16);
  v_updated_by RAW(16);
  CURSOR src_cursor IS
    SELECT region_name
    FROM src_regions;

  transformation_exception EXCEPTION;

BEGIN
  v_created_by := SYS_GUID();
  v_updated_by := SYS_GUID();
  OPEN src_cursor;

  LOOP
    FETCH src_cursor INTO v_name;
    EXIT WHEN src_cursor % NOTFOUND;
     v_description :=v_name;
    BEGIN
      v_id := SYS_GUID();
      INSERT INTO target_region (
        id, name, description, created_by, updated_by
      ) VALUES (
        v_id, v_name, v_description,v_created_by,v_updated_by
      );

      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        RAISE transformation_exception;
    END;
  END LOOP;

  CLOSE src_cursor;
EXCEPTION
  WHEN transformation_exception THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred during the data transformation.');
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found in source cursor.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END sp_src_regions_target_regions;
/



-- executing the stored procedure 
BEGIN
  sp_src_regions_target_regions;
END;
/

select * 
from target_region;

