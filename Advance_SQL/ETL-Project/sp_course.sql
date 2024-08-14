CREATE OR REPLACE PROCEDURE sp_course_transformation
AS 
  v_id RAW(16);
  v_name VARCHAR2(100);
  v_base_course NUMBER(1,0) := 1;
  v_is_active NUMBER(1,0) := 1;
  v_created_by RAW(16);
  v_updated_by RAW(16);

  CURSOR src_cursor IS 
    SELECT DISTINCT(course_name)
    FROM src_course_enrollment;

  transformation_error EXCEPTION;

BEGIN
  v_created_by := SYS_GUID();
  v_updated_by := SYS_GUID();
  
  OPEN src_cursor;
  LOOP
    FETCH src_cursor INTO v_name;
    EXIT WHEN src_cursor%NOTFOUND;

    v_id := SYS_GUID();
    
    BEGIN
      INSERT INTO target_course (
        id, name, base_course, is_active, created_by, updated_by, deleted_by)
      VALUES (
        v_id, v_name, v_base_course, v_is_active, v_created_by, v_updated_by, NULL);

    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred for course: ' || v_name || ' - ' || SQLERRM);
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
END sp_course_transformation;
/

--Excuting the procedure 
BEGIN
  sp_course_transformation;
END;
/

select *
from target_course;