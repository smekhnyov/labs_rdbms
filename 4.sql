SET SERVEROUTPUT ON;
SET TIMING ON;

CREATE TABLE RATING_ALERTS (
  ALERT_ID INTEGER PRIMARY KEY,
  UNIV_ID INTEGER,
  OLD_RATING INTEGER,
  NEW_RATING INTEGER,
  AVG_RATING NUMBER(5, 2),
  ALERT_MSG CHAR(255),
  ALERT_DATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE RATING_ALERTS_SEQ
START WITH 1  -- Начальное значение последовательности
INCREMENT BY 1;  -- Шаг увеличения

CREATE OR REPLACE TRIGGER CHECK_RATING
BEFORE INSERT OR UPDATE ON UNIVERSITY
FOR EACH ROW
DECLARE
  avg_rating NUMBER;
  threshold NUMBER := 50; -- Пороговое значение отклонения
BEGIN
  -- Вычисление среднего рейтинга по университетам
  SELECT AVG(RATING) INTO avg_rating FROM UNIVERSITY WHERE RATING IS NOT NULL;
  
  -- Проверка на превышение порога отклонения
  IF (:NEW.RATING > avg_rating + threshold OR :NEW.RATING < avg_rating - threshold) THEN
    DBMS_OUTPUT.PUT_LINE('Рейтинг университета превышает порог отклонения.');

    INSERT INTO RATING_ALERTS (ALERT_ID, UNIV_ID, OLD_RATING, NEW_RATING, AVG_RATING, ALERT_MSG)
    VALUES (
      RATING_ALERTS_SEQ.NEXTVAL,  -- Идентификатор события
      :NEW.UNIV_ID,               -- ID университета
      :OLD.RATING,                -- Старое значение рейтинга (если обновление)
      :NEW.RATING,                -- Новое значение рейтинга
      avg_rating,                 -- Средний рейтинг
      'Рейтинг университета превышает пороговое значение!'
    );
  END IF;
END;
/


INSERT INTO UNIVERSITY (UNIV_ID, UNIV_NAME, RATING, CITY) VALUES (51, 'ГУ БГТУ', 500, 'Губкин'); -- меньше порога
INSERT INTO UNIVERSITY (UNIV_ID, UNIV_NAME, RATING, CITY) VALUES (52, 'ГУ МИСиС', 550, 'Губкин'); -- больше порога
