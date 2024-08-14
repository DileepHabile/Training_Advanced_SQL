CREATE OR REPLACE PROCEDURE sp_Location_transfer 
AS 
  v_id RAW(16);
  v_name VARCHAR2(100);
  v_is_active NUMBER(1,0);
  v_is_default NUMBER(1,0) := 0; -- Assuming default is 0, adjust if necessary
  v_start_time DATE := TO_DATE('09:00:00', 'HH24:MI:SS');
  v_end_time DATE := TO_DATE('17:00:00', 'HH24:MI:SS');
  v_class_timing DATE := TO_DATE('10:00:00', 'HH24:MI:SS');
  v_region_id RAW(16);
  v_address_id RAW(16);
  v_description VARCHAR2(200);
  v_created_by RAW(16);
  v_updated_by RAW(16);
  
  
  v_region src_centers.region%TYPE;
  v_address src_centers.address%TYPE;
  v_clob_address CLOB;

  CURSOR src_cursor IS 
    SELECT name, active_status, region,address
    FROM src_centers;

  transformation_error EXCEPTION;

BEGIN 
  v_created_by := SYS_GUID();
  v_updated_by := SYS_GUID();

  OPEN src_cursor;
  LOOP
    FETCH src_cursor INTO v_name, v_is_active, v_region, v_address;
    EXIT WHEN src_cursor%NOTFOUND;

    BEGIN
      -- Convert active status
      IF v_is_active = 'TRUE' THEN 
        v_is_active := 1;
      ELSE 
        v_is_active := 0;
      END IF;

      -- Lookup region ID
      BEGIN 
        SELECT id INTO v_region_id
        FROM target_region
        WHERE name = v_region;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_region_id := NULL; -- Handle this scenario as appropriate
      END;

      -- Lookup address ID
      BEGIN 
        SELECT id INTO v_address_id
        FROM target_address_2
        WHERE address=v_address;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_address_id := NULL; -- Handle this scenario as appropriate
      END;

      -- Generate a new ID for the target table entry
      v_id := SYS_GUID();

      -- Insert into target table
      INSERT INTO target_location (
        id, name, is_active, is_default, start_time, end_time, class_timing, region_id, address_id, description, created_by, updated_by)
      VALUES (
        v_id, v_name, v_is_active, v_is_default, v_start_time, v_end_time, v_class_timing, v_region_id, v_address_id, v_description, v_created_by, v_updated_by);
      
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred for record: ' || v_name || ' - ' || SQLERRM);
        ROLLBACK;
        RAISE transformation_error;
    END;
  END LOOP;

  CLOSE src_cursor;
  COMMIT;
  
EXCEPTION
  WHEN transformation_error THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred during the data transformation.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
    ROLLBACK;
END sp_Location_transfer;
/

BEGIN
  sp_Location_transfer;
END;
/

select * from target_location;

