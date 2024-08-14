create or replace 
PROCEDURE SP_src_users_tar_users
AS
  v_user_id RAW(16);
  v_user_first_name src_users.first_name%type;
  v_user_last_name src_users.last_name%type;
  v_user_middle_name src_users.middle_name%type;
  v_user_gender src_users.gender%type := 'M';
  v_user_is_active NUMBER(1,0)        := 1;
  v_contact_number src_users.contact_number%type;
  v_manabadi_email src_users.manabadi_id%type;
  v_personal_email src_users.email%type;
  v_address_id  target_users.address_id%type; -- foreign key reference to src_users.id
  v_created_by    RAW(16);
  v_updated_by    RAW(16);
  v_clob_address clob;
  v_src_address src_users.address%type;
  transformation_error EXCEPTION;
  CURSOR src_cursor
  IS
    SELECT 
      first_name,
      last_name,
      middle_name,
      contact_number,
      manabadi_id,
      email,
      address
    FROM src_users;
    
BEGIN
  V_CREATED_BY := SYS_GUID();
  V_UPDATED_BY := SYS_GUID();
  
  OPEN src_cursor;
  LOOP
    FETCH src_cursor
    INTO
      v_user_first_name,
      v_user_last_name,
      v_user_middle_name,
      v_contact_number,
      v_manabadi_email,
      v_personal_email,
      v_src_address;
    EXIT
  WHEN src_cursor%NOTFOUND;
    BEGIN
       v_clob_address := TO_CLOB(v_src_address);

  
        SELECT id INTO v_address_id
        FROM target_address
        WHERE DBMS_LOB.INSTR(address, v_clob_address) > 0
        AND ROWNUM = 1;

      V_USER_ID := SYS_GUID();

      INSERT
      INTO target_users
        (
          id,
          first_name,
          last_name,
          middle_name,
          gender,
          is_active,
          contact_number,
          manabadi_email,
          personal_email,
          address_id,
          created_by,
          updated_by
        )
        VALUES
        (
          v_user_id,
          v_user_first_name,
          v_user_last_name,
          v_user_middle_name,
          v_user_gender,
          v_user_is_active,
          v_contact_number,
          v_manabadi_email,
          v_personal_email,
          v_address_id,
          v_created_by,
          v_updated_by
        );
      COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE transformation_error;
    END;
  END LOOP;
  CLOSE src_cursor;
EXCEPTION
WHEN transformation_error THEN
  DBMS_OUTPUT.PUT_LINE('Error occurred during the data transformation.');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END SP_src_users_tar_users;