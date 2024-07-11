--1. Create a PL/SQL program that declares a nested table of integers,
--populates it with values (e.g., 10, 20, 30), and then displays the elements of the nested table.
--2.Create a PL/SQL program that declares a varray of characters with a fixed size of 5.
--Implement a loop to take input from the user for all five elements of the varray and then display the contents of the varray.
--3.Create a PL/SQL program that declares an associative array (index-by table) of student names and their respective scores in a test.
--Populate the array with at least five records and then display the student names along with their scores.
-- Assoociative array is nothing but the index-by table
SET SERVEROUTPUT ON
DECLARE
TYPE students_marks_indexTable
IS
  TABLE OF INTEGER INDEX BY VARCHAR2(100);
  students_table_1 students_marks_indexTable ;
BEGIN
  students_table_1('Luffy')  :=90;
  students_table_1('Zoro')   :=80;
  students_table_1('Nami')   :=50;
  students_table_1('Usopp')  :=55;
  students_table_1('Sanji')  :=750;
  students_table_1('Chopper'):=10;
  students_table_1('Robin')  :=60;
  students_table_1('Franky') :=58;
  students_table_1('Brook')  :=62;
  students_table_1('Jinbe')  :=78;
  FOR student_name IN students_table_1.FIRST .. students_table_1.LAST
  LOOP
    DBMS_OUTPUT.PUT_LINE('NAME: '|| student_name || ',MARKS: ' || TO_CHAR(students_table_1(student_name)));
  END LOOP;
END;
-- 4.Write a PL/SQL program that uses an associative array of question 3. Calculate the average of all the values of the scores in the array.
SET SERVEROUTPUT ON
DECLARE
TYPE students_marks_indexTable
IS
  TABLE OF INTEGER INDEX BY VARCHAR2(100);
  students_table_1 students_marks_indexTable ;
  v_total_marks    INTEGER :=0;
  v_total_students INTEGER :=0;
  v_average        NUMBER  :=0;
BEGIN
  students_table_1('Luffy')  :=90;
  students_table_1('Zoro')   :=80;
  students_table_1('Nami')   :=50;
  students_table_1('Usopp')  :=55;
  students_table_1('Sanji')  :=750;
  students_table_1('Chopper'):=10;
  students_table_1('Robin')  :=60;
  students_table_1('Franky') :=58;
  students_table_1('Brook')  :=62;
  students_table_1('Jinbe')  :=78;
  FOR student_name IN students_table_1.FIRST .. students_table_1.LAST
  LOOP
    v_total_marks   :=v_total_marks    + students_table_1(student_name);
    v_total_students:=v_total_students +1;
  END LOOP;
  IF v_total_students >0 THEN
    v_average        :=v_total_marks/v_total_students;
    DBMS_OUTPUT.PUT_LINE('The average Marks of the total students is : ' || TO_CHAR(v_average));
  ELSE
    DBMS_OUTPUT.PUT_LINE('There are no students present');
  END IF;
END;
--5.Create a PL/SQL program that declares a nested table of timestamps.
--Implement a loop to populate the collection with timestamps representing different dates and times,
--and then display the timestamps in chronological order.
