CREATE TABLE university_summary (
    univ_id NUMBER,
    lect_count NUMBER,
    function_call_count NUMBER
);

CREATE OR REPLACE PACKAGE univ_pkg IS
    FUNCTION count_lect(univer_id IN NUMBER) RETURN NUMBER;
    PROCEDURE log_summary;
END univ_pkg;


CREATE OR REPLACE PACKAGE BODY univ_pkg IS
    FUNCTION_CALLS NUMBER := 0;
    LAST_UNIV_ID NUMBER := NULL;

    FUNCTION count_lect(univer_id IN NUMBER) RETURN NUMBER IS
        lect_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO lect_count
        FROM LECTURER
        WHERE UNIV_ID = count_lect.univer_id;

        FUNCTION_CALLS := FUNCTION_CALLS + 1;
        LAST_UNIV_ID := univer_id;

        RETURN lect_count;
    END count_lect;

    PROCEDURE log_summary IS
        lect_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO lect_count
        FROM LECTURER
        WHERE UNIV_ID = LAST_UNIV_ID;

        INSERT INTO university_summary (univ_id, lect_count, function_call_count)
        VALUES (LAST_UNIV_ID, lect_count, FUNCTION_CALLS);

        COMMIT;
    END log_summary;
END univ_pkg;

set serveroutput on
set timing on

DECLARE
    lect_count NUMBER;
BEGIN
    lect_count := univ_pkg.count_lect(2);

    univ_pkg.log_summary;
END;

