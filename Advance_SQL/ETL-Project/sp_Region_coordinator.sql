CREATE OR REPLACE PROCEDURE sp_target_region_coordinator
AS
  v_id RAW(16);
  v_is_primary NUMBER(1,0);
  v_region_id RAW(16);
  v_user_id RAW(16);
  v_created_by RAW(16);
  v_updated_by RAW(16);
  v_first_entry BOOLEAN := TRUE;
  v_region_name src_regions.region_name%TYPE;
  v_regional_coordinator src_regions.regional_coordinator%TYPE;
  
  CURSOR src_cursor IS 
    SELECT region_name, regional_coordinator
    FROM src_regions;

  transformation_exception EXCEPTION;

BEGIN
  v_created_by := SYS_GUID();
  v_updated_by := SYS_GUID();
  
  OPEN src_cursor;
  LOOP
    FETCH src_cursor INTO v_region_name, v_regional_coordinator;
    EXIT WHEN src_cursor%NOTFOUND;
    v_id := SYS_GUID();
    
    BEGIN
      -- Set primary/secondary flag
      IF v_first_entry THEN
        v_is_primary := 1;
        v_first_entry := FALSE;
      ELSE
        v_is_primary := 0;
      END IF;

      -- Lookup region_id
      BEGIN
        SELECT id INTO v_region_id
        FROM target_region
        WHERE  name = v_region_name;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_region_id := NULL; 
      END;

      -- Lookup user_id
      BEGIN
        SELECT id INTO v_user_id
        FROM target_users
        WHERE manabadi_email = v_regional_coordinator;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_user_id := NULL; 
      END;

      -- Insert into target table
      INSERT INTO target_region_coordinator
        (
          id,
          is_primary,
          region_id,
          user_id,
          created_by,
          updated_by
        )
      VALUES
        (
          v_id,
          v_is_primary,
          v_region_id,
          v_user_id,
          v_created_by,
          v_updated_by
        );

    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred for region: ' || v_region_name || ' - ' || SQLERRM);
        ROLLBACK;
        RAISE transformation_exception;
    END;
  END LOOP;

  CLOSE src_cursor;
  COMMIT;
EXCEPTION
  WHEN transformation_exception THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred during the transformation.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
    ROLLBACK;
END sp_target_region_coordinator;
/


BEGIN
  sp_target_region_coordinator;
END;
/

select *
from target_region_coordinator;