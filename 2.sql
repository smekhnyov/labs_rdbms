CREATE OR REPLACE PROCEDURE insert_lecturer (
    tmp_LECTURER_ID IN NUMBER,
    tmp_NAME  IN VARCHAR2,
    tmp_SURNAME   IN VARCHAR2,
    tmp_CITY  IN VARCHAR2,
    tmp_UNIV_ID IN NUMBER
) IS
BEGIN
    INSERT INTO LECTURER (LECTURER_ID, NAME, SURNAME, CITY, UNIV_ID)
    VALUES (tmp_LECTURER_ID, tmp_NAME, tmp_SURNAME, tmp_CITY, tmp_UNIV_ID);
    
    -- Зафиксировать изменения
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;

EXEC insert_lecturer(49, 'Иван', 'Иванов', 'Москва', 15);
