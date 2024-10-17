SET SERVEROUTPUT ON
SET TIMING ON

DROP TABLE Sales;
DROP TABLE Mechanic_specialty_assigments;
DROP TABLE Mechanic_specialties;
DROP TABLE Cars;
DROP TABLE Employee;
DROP TABLE Positions;

CREATE TABLE Positions (
    position_id number(10,0),
    position_name varchar2(255) NOT NULL,
    PRIMARY KEY (position_id)
);
INSERT INTO Positions (position_id, position_name)
VALUES (1, 'Agent');
INSERT INTO Positions (position_id, position_name)
VALUES (2, 'Secretary');
INSERT INTO Positions (position_id, position_name)
VALUES (3, 'Mechanic');

CREATE TABLE Employee (
	employee_id number(10,0),
	first_name varchar2(255) NOT NULL,
	last_name varchar2(255) NOT NULL,
	position number(10) NOT NULL,
	hire_date date NOT NULL,
	salary number(10) NOT NULL,
	commission_rate number(10) NOT NULL,
	work_hours number(10) NOT NULL,
	experience_years number(10) NOT NULL,
	PRIMARY KEY (employee_id),
	CONSTRAINT Employee_fk1 FOREIGN KEY (position) REFERENCES Positions(position_id)
);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (1, 'John', 'Doe', 1, TO_DATE('2020-05-10', 'YYYY-MM-DD'), 30000, 0, 40, 2);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (2, 'Jane', 'Smith', 2, TO_DATE('2019-03-15', 'YYYY-MM-DD'), 20000, 0, 30, 5);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (3, 'Bob', 'Johnson', 3, TO_DATE('2018-06-20', 'YYYY-MM-DD'), 25000, 0, 35, 6);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (4, 'Alice', 'Green', 1, TO_DATE('2021-01-20', 'YYYY-MM-DD'), 32000, 0, 40, 2);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (5, 'Eve', 'White', 1, TO_DATE('2015-04-15', 'YYYY-MM-DD'), 35000, 0, 40, 9);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (6, 'Charlie', 'Black', 3, TO_DATE('2017-11-10', 'YYYY-MM-DD'), 28000, 0, 40, 6);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (7, 'David', 'Blue', 3, TO_DATE('2020-02-05', 'YYYY-MM-DD'), 26000, 0, 40, 3);

CREATE TABLE Cars (
	car_id number(10,0),
	purchase_date date NOT NULL,
	estimated_value number(10) NOT NULL,
	repair_cost number(10) NOT NULL,
	mark varchar2(255) NOT NULL,
	model varchar2(255) NOT NULL,
	year number(10) NOT NULL,
	color varchar2(255) NOT NULL,
	mechanic_id number(10),
	PRIMARY KEY (car_id),
	CONSTRAINT Cars_fk8 FOREIGN KEY (mechanic_id) REFERENCES Employee(employee_id)
);
INSERT INTO Cars (car_id, purchase_date, estimated_value, repair_cost, mark, model, year, color, mechanic_id)
VALUES (1, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 15000, 500, 'Toyota', 'Corolla', 2018, 'Red', 3);
INSERT INTO Cars (car_id, purchase_date, estimated_value, repair_cost, mark, model, year, color, mechanic_id)
VALUES (2, TO_DATE('2023-07-15', 'YYYY-MM-DD'), 12000, 300, 'Volkswagen', 'Golf 8', 2017, 'Blue', 6);
INSERT INTO Cars (car_id, purchase_date, estimated_value, repair_cost, mark, model, year, color, mechanic_id)
VALUES (3, TO_DATE('2023-06-20', 'YYYY-MM-DD'), 10000, 800, 'Ford', 'Focus', 2016, 'White', 7);

CREATE TABLE Mechanic_specialties (
	specialty_id number(10,0),
	specialty_name varchar2(255) NOT NULL,
	PRIMARY KEY (specialty_id)
);
INSERT INTO Mechanic_specialties (specialty_id, specialty_name)
VALUES (1, 'Engine Overhaul');
INSERT INTO Mechanic_specialties (specialty_id, specialty_name)
VALUES (2, 'Dent Repair');
INSERT INTO Mechanic_specialties (specialty_id, specialty_name)
VALUES (3, 'Transmission Repair');

CREATE TABLE Mechanic_specialty_assigments (
	employee_id number(10) NOT NULL,
	specialty_id number(10) NOT NULL,
	PRIMARY KEY (employee_id, specialty_id),
	CONSTRAINT Mechanic_specialty_assigments_fk0 FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
	CONSTRAINT Mechanic_specialty_assigments_fk1 FOREIGN KEY (specialty_id) REFERENCES Mechanic_specialties(specialty_id)
);
INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (3, 1);
INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (3, 2);
INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (6, 1);
INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (6, 3);
INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (7, 2);

CREATE TABLE Sales (
	sale_id number(10,0),
	car_id number(10),
	sale_date date NOT NULL,
	sale_price number(10) NOT NULL,
	agent_id number(10),
	PRIMARY KEY (sale_id),
	CONSTRAINT Sales_fk1 FOREIGN KEY (car_id) REFERENCES Cars(car_id),
	CONSTRAINT Sales_fk4 FOREIGN KEY (agent_id) REFERENCES Employee(employee_id)
);
INSERT INTO Sales (sale_id, car_id, sale_date, sale_price, agent_id)
VALUES (1, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 17000, 1);
INSERT INTO Sales (sale_id, car_id, sale_date, sale_price, agent_id)
VALUES (2, 2, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 14000, 1);
INSERT INTO Sales (sale_id, car_id, sale_date, sale_price, agent_id)
VALUES (3, 3, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 11000, 1);
INSERT INTO Sales (sale_id, car_id, sale_date, sale_price, agent_id)
VALUES (4, 2, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 20000, 2);

CREATE OR REPLACE TRIGGER CALCULATE_COMMISSION
BEFORE INSERT OR UPDATE ON Employee
FOR EACH ROW
WHEN (NEW.POSITION = 1)
BEGIN
    IF :NEW.EXPERIENCE_YEARS < 3 THEN
        :NEW.COMMISSION_RATE := 5;
    ELSE
        :NEW.COMMISSION_RATE := 8;
    END IF;
END;

INSERT INTO Positions (position_id, position_name)
VALUES (1, 'Agent');
INSERT INTO Positions (position_id, position_name)
VALUES (2, 'Secretary');
INSERT INTO Positions (position_id, position_name)
VALUES (3, 'Mechanic');

INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (1, 'John', 'Doe', 1, TO_DATE('2020-05-10', 'YYYY-MM-DD'), 30000, 0, 40, 2);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (2, 'Jane', 'Smith', 2, TO_DATE('2019-03-15', 'YYYY-MM-DD'), 20000, 0, 30, 5);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (3, 'Bob', 'Johnson', 3, TO_DATE('2018-06-20', 'YYYY-MM-DD'), 25000, 0, 35, 6);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (4, 'Alice', 'Green', 1, TO_DATE('2021-01-20', 'YYYY-MM-DD'), 32000, 0, 40, 2);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (5, 'Eve', 'White', 1, TO_DATE('2015-04-15', 'YYYY-MM-DD'), 35000, 0, 40, 9);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (6, 'Charlie', 'Black', 3, TO_DATE('2017-11-10', 'YYYY-MM-DD'), 28000, 0, 40, 6);
INSERT INTO Employee (employee_id, first_name, last_name, position, hire_date, salary, commission_rate, work_hours, experience_years)
VALUES (7, 'David', 'Blue', 3, TO_DATE('2020-02-05', 'YYYY-MM-DD'), 26000, 0, 40, 3);

INSERT INTO Cars (car_id, purchase_date, estimated_value, repair_cost, mark, model, year, color, mechanic_id)
VALUES (1, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 15000, 500, 'Toyota', 'Corolla', 2018, 'Red', 3);
INSERT INTO Cars (car_id, purchase_date, estimated_value, repair_cost, mark, model, year, color, mechanic_id)
VALUES (2, TO_DATE('2023-07-15', 'YYYY-MM-DD'), 12000, 300, 'Volkswagen', 'Golf 8', 2017, 'Blue', 6);
INSERT INTO Cars (car_id, purchase_date, estimated_value, repair_cost, mark, model, year, color, mechanic_id)
VALUES (3, TO_DATE('2023-06-20', 'YYYY-MM-DD'), 10000, 800, 'Ford', 'Focus', 2016, 'White', 7);

INSERT INTO Mechanic_specialties (specialty_id, specialty_name)
VALUES (1, 'Engine Overhaul');
INSERT INTO Mechanic_specialties (specialty_id, specialty_name)
VALUES (2, 'Dent Repair');
INSERT INTO Mechanic_specialties (specialty_id, specialty_name)
VALUES (3, 'Transmission Repair');

INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (3, 1);
INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (3, 2);
INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (6, 1);
INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (6, 3);
INSERT INTO Mechanic_specialty_assigments (employee_id, specialty_id)
VALUES (7, 2);

INSERT INTO Sales (sale_id, car_id, sale_date, sale_price, agent_id)
VALUES (1, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 17000, 1);
INSERT INTO Sales (sale_id, car_id, sale_date, sale_price, agent_id)
VALUES (2, 2, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 14000, 1);
INSERT INTO Sales (sale_id, car_id, sale_date, sale_price, agent_id)
VALUES (3, 3, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 11000, 1);
INSERT INTO Sales (sale_id, car_id, sale_date, sale_price, agent_id)
VALUES (4, 2, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 20000, 2);

CREATE OR REPLACE TRIGGER CASCADE_UPDATE_EMPLOYEE
AFTER UPDATE OF employee_id ON Employee
FOR EACH ROW
BEGIN
    UPDATE Cars SET mechanic_id = :NEW.employee_id WHERE mechanic_id = :OLD.employee_id;
    UPDATE Sales SET agent_id = :NEW.employee_id WHERE agent_id = :OLD.employee_id;
    UPDATE Mechanic_specialty_assigments SET employee_id = :NEW.employee_id WHERE employee_id = :OLD.employee_id;
END;
/
-- UPDATE Employee SET EMPLOYEE_ID = 10 WHERE employee_id = 1;

CREATE OR REPLACE TRIGGER CASCADE_UPDATE_CAR
AFTER UPDATE OF car_id ON Cars
FOR EACH ROW
BEGIN
    UPDATE Sales SET car_id = :NEW.car_id WHERE car_id = :OLD.car_id;
END;
/
-- UPDATE Cars SET car_id = 10 WHERE car_id = 1;

CREATE OR REPLACE TRIGGER CASCADE_UPDATE_POSITION
AFTER UPDATE OF position_id ON Positions
FOR EACH ROW
BEGIN
    UPDATE Employee SET position = :NEW.position_id WHERE position = :OLD.position_id;
END;
/
-- UPDATE Positions SET position_id = 10 WHERE position_id = 1;

CREATE OR REPLACE TRIGGER CASCADE_UPDATE_SPETIALTY
AFTER UPDATE OF specialty_id ON MECHANIC_SPECIALTIES
FOR EACH ROW
BEGIN
    UPDATE MECHANIC_SPECIALTY_ASSIGMENTS SET SPECIALTY_ID = :NEW.SPECIALTY_ID WHERE SPECIALTY_ID = :OLD.SPECIALTY_ID;
END;
/
-- UPDATE MECHANIC_SPECIALTIES SET specialty_id = 10 WHERE specialty_id = 1;

CREATE OR REPLACE TRIGGER CASCADE_DELETE_EMPLOYEE
AFTER DELETE ON Employee
FOR EACH ROW
BEGIN
    UPDATE Cars SET MECHANIC_ID = NULL WHERE mechanic_id = :OLD.employee_id;
    UPDATE Sales SET agent_id = NULL WHERE agent_id = :OLD.employee_id;
    DELETE FROM Mechanic_specialty_assigments WHERE employee_id = :OLD.employee_id;
END;
/

CREATE OR REPLACE TRIGGER CASCADE_DELETE_CAR
BEFORE DELETE ON Cars
FOR EACH ROW
BEGIN
    UPDATE Sales SET car_id = NULL WHERE car_id = :OLD.car_id;
END;
/

CREATE OR REPLACE TRIGGER CASCADE_DELETE_POSITION
BEFORE DELETE ON Positions
FOR EACH ROW
BEGIN
	UPDATE Employee SET position = NULL WHERE position = :OLD.position_id;
END;
/

CREATE OR REPLACE TRIGGER CASCADE_DELETE_SPECIALTY
BEFORE DELETE ON Mechanic_specialties
FOR EACH ROW
BEGIN
	UPDATE Mechanic_specialty_assigments SET specialty_id = NULL WHERE specialty_id = :OLD.specialty_id;
END;
/

CREATE OR REPLACE PACKAGE CarDealershipPackage AS
    FUNCTION GetAgentCommission(agent_id_param IN NUMBER, car_id_param IN NUMBER) RETURN NUMBER;

    FUNCTION GetLastMonthRevenue RETURN NUMBER;

    PROCEDURE ShowCarsByBrand(car_brand IN VARCHAR2);

    FUNCTION GetTotalSalesForYear(p_year NUMBER) RETURN NUMBER;

    PROCEDURE ShowMechanicsBySpecialty(specialty_name IN VARCHAR2);
END CarDealershipPackage;
/

CREATE OR REPLACE PACKAGE BODY CarDealershipPackage AS

    -- 1. Функция для вычисления комиссионных агента после продажи машины
    FUNCTION GetAgentCommission(agent_id_param IN NUMBER, car_id_param IN NUMBER) RETURN NUMBER IS
        commission NUMBER;
        sale_price NUMBER;
        commission_rate NUMBER;
    BEGIN
        -- Получаем цену продажи и комиссионный процент агента
        SELECT s.sale_price, e.commission_rate
        INTO sale_price, commission_rate
        FROM Sales s
        JOIN Employee e ON s.agent_id = e.employee_id
        WHERE s.agent_id = agent_id_param AND s.car_id = car_id_param;
        
        -- Вычисляем комиссионные
        commission := sale_price * (commission_rate / 100);
        
        RETURN commission;
    END GetAgentCommission;

    -- 2. Функция для получения выручки за прошлый месяц
    FUNCTION GetLastMonthRevenue RETURN NUMBER IS
        total_revenue NUMBER;
    BEGIN
        -- Считаем выручку за прошлый месяц
        SELECT SUM(sale_price)
        INTO total_revenue
        FROM Sales
        WHERE sale_date >= ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -1)
        AND sale_date < TRUNC(SYSDATE, 'MM');
        
        RETURN NVL(total_revenue, 0);
    END GetLastMonthRevenue;

    -- 3. Процедура для вывода всех автомобилей определенной марки
    PROCEDURE ShowCarsByBrand(car_brand IN VARCHAR2) IS
        CURSOR car_cursor IS
        SELECT car_id, mark, model, year, color, estimated_value
        FROM Cars
        WHERE mark = car_brand;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Автомобили марки ' || car_brand || ':');
        FOR car_rec IN car_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('ID: ' || car_rec.car_id || ', Модель: ' || car_rec.model || 
                                 ', Год: ' || car_rec.year || ', Цвет: ' || car_rec.color ||
                                 ', Стоимость: ' || car_rec.estimated_value);
        END LOOP;
    END ShowCarsByBrand;

    -- 4. Функция для подсчета общего количества проданных автомобилей за определенный год
    FUNCTION GetTotalSalesForYear(p_year NUMBER) RETURN NUMBER IS
    	total_sales NUMBER;
	BEGIN
    	SELECT COUNT(*)
    	INTO total_sales
    	FROM Sales
    	WHERE EXTRACT(YEAR FROM sale_date) = p_year;

    	RETURN total_sales;
	END;

    -- 5. Процедура для вывода всех механиков с определенной квалификацией
    PROCEDURE ShowMechanicsBySpecialty(specialty_name IN VARCHAR2) IS
        CURSOR mechanic_cursor IS
        SELECT DISTINCT e.employee_id, e.first_name, e.last_name
        FROM Employee e
        JOIN Mechanic_specialty_assigments msa ON e.employee_id = msa.employee_id
        JOIN Mechanic_specialties ms ON msa.specialty_id = ms.specialty_id
        WHERE ms.specialty_name = specialty_name;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Механики с квалификацией ' || specialty_name || ':');
        FOR mechanic_rec IN mechanic_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('ID: ' || mechanic_rec.employee_id || 
                                 ', Имя: ' || mechanic_rec.first_name || 
                                 ', Фамилия: ' || mechanic_rec.last_name);
        END LOOP;
    END ShowMechanicsBySpecialty;

END CarDealershipPackage;
/

DECLARE
    agent_id NUMBER := 1; -- Идентификатор агента
    car_id NUMBER := 1; -- Идентификатор машины
    commission NUMBER;
BEGIN
    commission := CarDealershipPackage.GetAgentCommission(agent_id, car_id);
    DBMS_OUTPUT.PUT_LINE('Комиссионные агента: ' || commission);
END;
/

DECLARE
    last_month_revenue NUMBER;
BEGIN
    last_month_revenue := CarDealershipPackage.GetLastMonthRevenue;
    DBMS_OUTPUT.PUT_LINE('Выручка за прошлый месяц: ' || last_month_revenue);
END;
/

BEGIN
    CarDealershipPackage.ShowCarsByBrand('Ford'); -- Выводим машины марки "Toyota"
END;
/

DECLARE
    total_sales NUMBER;
    sales_year NUMBER := 2023; -- Год, для которого нужно получить количество продаж
BEGIN
    total_sales := CarDealershipPackage.GetTotalSalesForYear(sales_year);
    DBMS_OUTPUT.PUT_LINE('Общее количество продаж за ' || sales_year || ': ' || total_sales);
END;
/


BEGIN
    CarDealershipPackage.ShowMechanicsBySpecialty('Engine Overhaul'); -- Выводим механиков с квалификацией "Engine Overhaul"
END;
/
