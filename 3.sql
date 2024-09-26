set serveroutput on
set timing on

-- Создание таблицы для хранения результатов
CREATE TABLE university_summary (
    univ_id NUMBER,
    lect_count NUMBER,
    function_call_count NUMBER
);

-- Создание пакета с функцией и процедурой
CREATE OR REPLACE PACKAGE univ_pkg IS
    FUNCTION count_lect(univ_id IN NUMBER) RETURN NUMBER;
    PROCEDURE log_summary;
END univ_pkg;


CREATE OR REPLACE PACKAGE BODY univ_pkg IS
    -- Глобальная переменная для хранения количества обращений к функции
    FUNCTION_CALLS NUMBER := 0;

    -- Функция для подсчета количества преподавателей
    FUNCTION count_lect(univ_id IN NUMBER) RETURN NUMBER IS
        lect_count NUMBER;
    BEGIN
        -- Пример запроса для подсчета преподавателей в университете
        SELECT COUNT(*)
        INTO lect_count
        FROM LECTURER
        WHERE UNIV_ID = count_lect.univ_id;

        -- Увеличиваем количество обращений к функции
        FUNCTION_CALLS := FUNCTION_CALLS + 1;

        RETURN lect_count;
    END count_lect;

    -- Процедура для логирования данных в таблицу
    PROCEDURE log_summary IS
    BEGIN
        -- Запись данных в таблицу university_summary
        INSERT INTO university_summary (univ_id, lect_count, function_call_count)
        VALUES (1, count_lect(1), FUNCTION_CALLS);

        COMMIT;
    END log_summary;
END univ_pkg;

-- Пример использования пакета
DECLARE
    lect_count NUMBER;
BEGIN
    -- Вызов функции из пакета
    lect_count := univ_pkg.count_lect(1);

    -- Вызов процедуры для логирования
    univ_pkg.log_summary;
END;

SELECT * FROM university_summary;
