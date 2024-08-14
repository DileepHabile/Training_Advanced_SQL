CREATE OR REPLACE PROCEDURE sp_enrolled_course_table AS
    v_id  RAW(16);
    v_student_id  RAW(16);
    v_academic_year VARCHAR2(9);
    v_academic_grade VARCHAR2(5);
    v_academic_school VARCHAR2(200);
    v_average_score VARCHAR2(11);
    v_result VARCHAR2(8);
    v_is_course_completed VARCHAR2(5);
    v_tshirt_size VARCHAR2(20);
    v_course_id  RAW(16);
    v_center_id  RAW(16);
    v_created_by  RAW(16);
    v_updated_by RAW(16);

    v_course_name src_course_enrollment.course_name%TYPE;
    v_center_name src_course_enrollment.center_name%TYPE;

    CURSOR src_cursor IS
        SELECT academic_year, academic_grade, academic_school, average_score, result, 
               course_completed, shirt_size, course_name, center_name
        FROM src_course_enrollment;

    transformation_error EXCEPTION;

BEGIN
    v_updated_by := SYS_GUID();
    v_created_by := SYS_GUID();

    FOR rec IN src_cursor LOOP
        v_academic_year := rec.academic_year;
        v_academic_grade := rec.academic_grade;
        v_academic_school := rec.academic_school;
        v_average_score := rec.average_score;
        v_result := rec.result;
        v_is_course_completed := rec.course_completed;
        v_tshirt_size := rec.shirt_size;
        v_course_name := rec.course_name;
        v_center_name := rec.center_name;

        -- Find course_id in target_course
        BEGIN
            SELECT id INTO v_course_id
            FROM target_course
            WHERE name = v_course_name;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20001, 'Course not found');
        END;

        -- Find center_id in target_exam_center
        BEGIN
            SELECT id INTO v_center_id
            FROM target_exam_center
            WHERE name = v_center_name;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                raise_application_error(-20002, 'Exam center not found');
        END;

        v_id := SYS_GUID();
        v_student_id := SYS_GUID();

        -- Insert into target_enrolled_course
        INSERT INTO target_enrolled_course (
            id, student_id, academic_year, academic_grade, academic_school, 
            average_score, result, is_course_completed, tshirt_size, 
            course_id, center_id, created_by, updated_by
        ) VALUES (
            v_id, v_student_id, v_academic_year, v_academic_grade, v_academic_school, 
            v_average_score, v_result, v_is_course_completed, v_tshirt_size, 
            v_course_id, v_center_id, v_created_by, v_updated_by
        );

    END LOOP;

EXCEPTION
    WHEN transformation_error THEN
        raise_application_error(-20000, 'Transformation error: ' || SQLERRM);
    WHEN OTHERS THEN
        raise_application_error(-20000, 'Unhandled error: ' || SQLERRM);

END sp_enrolled_course_table;
/


-- Executing the stored procedure
Begin
sp_enrolled_course_table;
End;


select *
from target_enrolled_course;