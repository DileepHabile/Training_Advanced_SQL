create or replace 
PROCEDURE sp_exam_center_transform
AS
  v_id RAW(16);
  v_name      VARCHAR2(100);
  v_is_active NUMBER(1,0);
  v_address_id RAW(16);
  v_location_id RAW(16);
  v_created_by RAW(16);
  v_updated_by RAW(16);
  v_address src_centers.address%TYPE;
  CURSOR src_cursor
  IS
    SELECT name, active_status, address FROM src_centers;
  transformation_error EXCEPTION;
BEGIN
  v_created_by := SYS_GUID();
  v_updated_by := SYS_GUID();
  OPEN src_cursor;
  LOOP
    FETCH src_cursor INTO v_name, v_is_active, v_address;
    EXIT
  WHEN src_cursor%NOTFOUND;
    v_id := SYS_GUID();
    BEGIN
      IF v_is_active = 'TRUE' THEN
        v_is_active := 1;
      ELSE
        v_is_active := 0;
      END IF;
    END;
    
    BEGIN
      SELECT id
      INTO v_address_id
      FROM target_address
      WHERE DBMS_LOB.SUBSTR(address, LENGTH(v_address)) = v_address;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_address_id := NULL; -- Handle this scenario as appropriate
    END;
    
    BEGIN
      SELECT id INTO v_location_id FROM target_location WHERE name = v_name;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_location_id := NULL; -- Handle this scenario as appropriate
    END;
    BEGIN
      INSERT
      INTO target_exam_center
        (
          id,
          name,
          is_active,
          address_id,
          location_id,
          created_by,
          updated_by
        )
        VALUES
        (
          v_id,
          v_name,
          v_is_active,
          v_address_id,
          v_location_id,
          v_created_by,
          v_updated_by
        );
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
END sp_exam_center_transform;