
CREATE OR REPLACE PROCEDURE sp_target_address AS
  v_id RAW(16);
  v_address target_address.address%TYPE;
  c_city constant target_address.city%TYPE := 'NY';
  c_country constant target_address.country%TYPE := 'USA';
  c_state constant target_address.state%TYPE := 'Manhattan';
  c_zip_code constant target_address.zipcode%TYPE := 1001;
  c_created_by RAW(16);
  c_updated_by RAW(16);

  cursor src_cursor is
    select address
    from src_users
    union 
    select address
    from src_centers
    union
    select academic_school
    from src_course_enrollment;

BEGIN
   c_created_by := SYS_GUID();
   c_updated_by := SYS_GUID();
  OPEN src_cursor;
  LOOP
    FETCH src_cursor INTO v_address;
    EXIT WHEN src_cursor%NOTFOUND;
    
    v_id :=SYS_GUID();
    INSERT INTO target_address (
      id,
      address,
      city,
      country,
      state,
      zipcode,
      created_by,
      updated_by
    ) VALUES (
      v_id,
      v_address,
      c_city,
      c_country,
      c_state,
      c_zip_code,
      c_created_by,
      c_updated_by
    );
    
  END LOOP;
  
  CLOSE src_cursor;
  COMMIT;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found in source cursor.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
    ROLLBACK;  -- Rollback in case of error
END sp_target_address;
/


BEGIN
  sp_target_address;
END;
/




select * from target_address;