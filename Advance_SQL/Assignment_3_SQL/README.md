# DECLARING VARIABLES IN PL/SQL

The given below is the PL/SQL Block structure 
The structure is as follows 

````SQL
DECLARE (Optional)
        Variables, cursors, user-defined exceptions
BEGIN (Mandatory)
    -SQL statements
    -PL/SQL statements
EXCEPTION (Optional)
    -- Actions to perform when error occurs
END;(Mandatory)
````

so hence as shown above we have in Block structure

====> Declare (variables,cursors,user-defined exceptions)-->This is exceptional
====> BEGIN (SQL statements ,PL/SQL statements )
====> EXCEPTION (Actions to perform when error occurs) --->This is exceptional
====> END; --->This is Mandatory


Example for the block structure of the PL/SQL

````SQL

DECLARE 
    v_variable VARCHAR2(5)
BEGIN
    SELECT column_name
    INTO v_variable
    FROM table_name;
EXCEPTION
    WHEN exception_name THEN
    ....

END;
````

Different Block types 
1) Anonymous 
2) Procedure
3) Function


1)Anonymous 
[DECLARE]

BEGIN
    --statements 
[EXCEPTION]

END;


2) Procedure 

PROCEDURE name
IS

BEGIN
    --statements
[EXCEPTION]
END;


3)Function

FUNCTION name 
RETURN datatype
IS 
BEGIN
    --statements
    RETURN value;
    [Exception]

END;


Program Constructs 

--> Tools Constructs 
   Anonymous blocks
   Application procedures or functions
   Application packages 
   Application triggers
   Object types 

--> Database server constructs 
    Anonymous blocks
    stored procedures or functions
    stored packages
    Database triggers
    Object types 


Use of Variables
=> Variables can be used for 
.Temporary storage of data
.Manipulation of strored values
.Reusability 
.Ease of maintenance

Handling Variables in PL/SQL
.Declare and initialize variables in the declaration
.Assign new values to varibales in the executable section
.Pass values into PL/SQL blocks through parameters
.View results through output variables 


Types of Variables 
=>PL/SQL Variables 
-Scalar 
-Composite
-Reference
-LOB(large objects)
=>Non-PL/SQL variables:Bind and host variables


Types of Variables used are 
-Boolean
-Date
-Clob(Large amount of text)
-Blob(Binary Large object -Images,videos)
-Varchar 

DECLARING PL/SQL Variables 

```SQL
 -- SYNTAX:
 -- identifer [constant]  datatype[NOT NULL] [:= | DEFAULT expr];
 -- The keywords that are in brackets are optional 

 -- examples
 DECLARE 
    v_hiredate DATE;
    v_deptno NUMBER(2) NOT NULL :=10;
    v_location VARCHAR2(13) :='Atlanta';
    c_comm CONSTANT NUMBER :=1400;

```

Guidelines for Declaring PL/SQL Variables 

.Follow naming conventions
.Initialize variables designated as NOT NULL and CONSTANT
.DECLARE one identifier per line
.initialize identifiers by using the assignment operator (:= ) or the DEFAULT reserved word 

  identifier :=expr;





=>Naming Rules
.Two variables can have the same name, provided they are in different blocks
.The variable name(identifier) should be not same as the name of table columns used in the block

Example

```SQL

DECLARE 
   employee_id NUMBER(6);
BEGIN
    SELECT  employee_id
    INTO employee_id
    FROM employees
    WHERE last_name='Kochhar';
END;

```
Adopt a naming conventions for PL/SQL identifiers for example, v_employee_id

=>Variable Initialization and keywords 
.Assignment operator(:=)
.DEFAULT keyword 
.NOT NULL constraint 

SYNTAX:
identifier :=expr;


Examples:
V_hiredate='01-JAN-2001';
v_ename:='Maduro';


=>SCALAR Data Types 

.Hold a single value
.Have no internal components 

--Base Scalar Data Types 
.CHAR[(maximum_length)]
.VARCHAR(maximum_length)
.LONG
.LONG RAW
.NUMBER 
.BINARY_INTEGER
.PLS_INTEGER
.BOOLEAN
.DATE
.TIMESTAMP
.TIMESTAMP WITH TIME ZONE
.TIMESTAMP WITH LOCAL TIME ZONE
.INTERVAL YEAR TO MONTH
.INTERVAL DAT TO SECOND


```SQL

DECLARE 
   v_job VARCHAR2(9);
   v_count BINARY_INTEGER :=0;
   v_total_sal NUMBER(9,2) :=0;
   v_orderdate DATE :=SYSDATE +7
   c_tax_rate CONSTANT NUMBER(3,2) :8.25
   v_valid BOOLEAN NOT NULL :=TRUE;

```

The %TYPE Attribute

.Declare a variable according to:
 - A database column definition
 - Another previously declared variable


. Prefix %TYPE with:
 - The database table and column
 - The previously declared variable name 


SYNTAX:

identifier Table.column_name%TYPE;

Examples:

v_name   employees.last_name%TYPE;
v_balance NUMBER (7,2);
v_min_balance v_balance%TYPE :=10;  // this identifier access the datatype of v_balance 


DECLARING Boolean Variables 
.Only the  Values TRUE , FALSE and NULL can be assigned to a BOOLEAN variable
.The Variables are compared by the logical operators AND,OR,and NOT 
.The Variables always yield TRUE,FALSE or NULL
.Arthimetic,character and date expressions can be used to return a Boolean value 








































































-- PL/SQL block to define variables and constants for all datatypes and print them

SET SERVEROUTPUT ON; -- Enable output

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
/
