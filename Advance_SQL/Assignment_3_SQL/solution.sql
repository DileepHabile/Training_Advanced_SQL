-- Write PL SQL blocks to define variables for all the data types and print their values in the output


-- 1.Varchar variable Ananymous block
SET SERVEROUTPUT ON
DECLARE 
 v_first_name VARCHAR2(13) :='Eren';
 v_last_name  VARCHAR2(13):='Yeager';
 v_place      VARCHAR2(13):='Paradise';
 
 BEGIN
  dbms_output.put_line('Varchar variable :' || v_first_name);
  dbms_output.put_line('Varchar variable:' || v_last_name);
  dbms_output.put_line('Varchar variable:' || v_place);
END;
 
 
 
 -- 2. NUMBER varibale block 
 
 SET SERVEROUTPUT ON
 DECLARE 
 v_integer  NUMBER:=12345;
 v_price  NUMBER:=20000;
 v_random NUMBER:=4.5;
 
 BEGIN
   DBMS_OUTPUT.PUT_LINE('Number Variable:' || v_integer);
   DBMS_OUTPUT.PUT_LINE('Number Variable:' || v_price);
   DBMS_OUTPUT.PUT_LINE('Number Variable:' || v_random);
END;
 
 
 
 
 
 ---3.BOOLEAN VARIABLE BLOCK
 -- A boolean variable cannot be declared as NULL
 SET SERVEROUTPUT ON
 
 DECLARE 
 
 v_islimit BOOLEAN:=TRUE;
 v_ispaid BOOLEAN:=FALSE;
 v_isreached BOOLEAN;
 
 BEGIN
 
DBMS_OUTPUT.PUT_LINE('Boolean Variable:' || CASE WHEN v_islimit THEN 'TRUE' ELSE 'FALSE' END);
DBMS_OUTPUT.PUT_LINE('Boolean Variable:'|| CASE WHEN v_ispaid THEN 'TRUE' ELSE 'FALSE' END );
DBMS_OUTPUT.PUT_LINE('Boolean Variable:' || CASE WHEN v_isreached THEN 'TRUE' ELSE 'FALSE' END  );
 
 END;
 
 
 
 
 --- 4.Date Varibale 
 
 
 SET SERVEROUTPUT ON
 
 DECLARE 
 v_today DATE:=SYSDATE;
 v_joiningDate DATE:= TO_DATE('2024-07-03','YYYY-MM-DD');
 
 BEGIN 
 DBMS_OUTPUT.PUT_LINE('Date Variable' || v_today);
 DBMS_OUTPUT.PUT_LINE('Date Variable' || v_joiningDate);
 
 END;
 
 
 
 -- 5.CLOB DATATYPE
 
 SET SERVEROUTPUT ON
 DECLARE 
 v_text CLOB;
 BEGIN
 v_text:='This is Eren Yeager ,I am THE ATTACK TITAN';
 v_text:=v_text || ' I am from Paradis';
 
 dbms_output.put_line('CLOB Variable:' || v_text);
 
 END;
 
 -- 6.DECIMAL 
 
 SET SERVEROUTPUT ON
 DECLARE 
 c_area CONSTANT NUMBER(10,2):=345.56;
 c_height NUMBER(10,2):=5.12;
 BEGIN
 dbms_output.put_line('DECIMAL Variable:' || c_area);
 dbms_output.put_line('DECIMAL Variable:' || c_height);
 END;
 
 
 
 -- 7.CHAR 
 -- This data type is used to store fixed -length character strings
 SET SERVEROUTPUT ON
 DECLARE
    v_char_variable CHAR(10); 
BEGIN
    v_char_variable := 'Hello'; 
    DBMS_OUTPUT.PUT_LINE('CHAR Variable: ' || v_char_variable);
END;



--8.LONG DATA TYPE
-- This is genearally used for the variable length character type upto 2GB .But geereally Nowadays we use CLOB
 SET SERVEROUTPUT ON
DECLARE
    v_long_variable LONG;  
BEGIN
    v_long_variable := 'This is a long string...'; 
    DBMS_OUTPUT.PUT_LINE('LONG Variable: ' || v_long_variable);
END;



 --9 LONG RAW DATA TYPE Example  similar to that of CLOB
 -- This data type is used to store binary data up to 2gb  nowadays BLOB is used instead 
 SET SERVEROUTPUT ON
 DECLARE
    v_long_raw_variable LONG RAW;  
BEGIN
    v_long_raw_variable := 'FFD8FFE000104A46494600010101004800480000';  -- Example hexadecimal value for image data
    DBMS_OUTPUT.PUT_LINE('LONG RAW Variable: ' || v_long_raw_variable);
END;


 
 
--10. Binary Integer
--The below data type is used to store signed integer values in the range of -2billion to +2billion

SET SERVEROUTPUT ON
DECLARE
    v_binary_integer_variable BINARY_INTEGER;
BEGIN
    v_binary_integer_variable := 12345; 
    DBMS_OUTPUT.PUT_LINE('BINARY_INTEGER Variable: ' || v_binary_integer_variable);
END;



 
SET SERVEROUTPUT ON

DECLARE
    -- Variable declarations
    v_integer NUMBER := 123;
    v_decimal NUMBER(10,2) := 456.78;
    v_char CHAR(10) := 'Hello';
    v_varchar VARCHAR2(20) := 'World';
    v_date DATE := SYSDATE;
    v_boolean BOOLEAN := TRUE;

    -- Constant declarations
    c_pi CONSTANT NUMBER := 3.14159;
    c_author CONSTANT VARCHAR2(50) := 'John Doe';

BEGIN
    -- Print variables
    DBMS_OUTPUT.PUT_LINE('Integer variable: ' || v_integer);
    DBMS_OUTPUT.PUT_LINE('Decimal variable: ' || v_decimal);
    DBMS_OUTPUT.PUT_LINE('Character variable: ' || v_char);
    DBMS_OUTPUT.PUT_LINE('Varchar variable: ' || v_varchar);
    DBMS_OUTPUT.PUT_LINE('Date variable: ' || TO_CHAR(v_date, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('Boolean variable: ' || CASE WHEN v_boolean THEN 'TRUE' ELSE 'FALSE' END);

    -- Print constants
    DBMS_OUTPUT.PUT_LINE('Constant PI: ' || c_pi);
    DBMS_OUTPUT.PUT_LINE('Constant Author: ' || c_author);
END;
