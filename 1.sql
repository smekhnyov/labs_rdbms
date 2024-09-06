DECLARE
  arg1 subj_lect.lecturer_id%TYPE;
  arg2 subj_lect.subj_id%TYPE;
  CURSOR cur1 IS SELECT * FROM subj_lect sl;
  special_case EXCEPTION;
  BEGIN
    OPEN cur1;
    FETCH cur1 INTO arg1, arg2;
    WHILE cur1%FOUND LOOP
      IF arg2 = 2 -- subject
        THEN dbms_output.put_line(arg1  ' '  arg2);
      END IF;
      FETCH cur1 INTO arg1, arg2;
    END LOOP;
    EXCEPTION
      WHEN special_case THEN
        dbms_output.put_line('Пользовательское исключение');
      WHEN OTHERS THEN
        dbms_output.put_line('Ошибка приложения');
    END;
