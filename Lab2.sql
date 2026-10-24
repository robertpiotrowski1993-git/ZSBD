--Zad 1

--DROP TABLE COUNTRIES CASCADE CONSTRAINTS;
--DROP TABLE DEPARTMENTS CASCADE CONSTRAINTS;
--DROP TABLE EMPLOYEES CASCADE CONSTRAINTS;
--DROP TABLE JOBS CASCADE CONSTRAINTS;
--DROP TABLE JOB_HISTORY CASCADE CONSTRAINTS;
--DROP TABLE LOCATIONS CASCADE CONSTRAINTS;
--DROP TABLE REGIONS CASCADE CONSTRAINTS;

--Zad 2

--CREATE TABLE REGIONS AS SELECT * FROM HR.REGIONS;
--CREATE TABLE COUNTRIES AS SELECT * FROM HR.COUNTRIES;
--CREATE TABLE LOCATIONS AS SELECT * FROM HR.LOCATIONS;
--CREATE TABLE DEPARTMENTS AS SELECT * FROM HR.DEPARTMENTS;
--CREATE TABLE JOBS AS SELECT * FROM HR.JOBS;
--CREATE TABLE EMPLOYEES AS SELECT * FROM HR.EMPLOYEES;
--CREATE TABLE JOB_HISTORY AS SELECT * FROM HR.JOB_HISTORY;
--CREATE TABLE JOB_GRADES AS SELECT * FROM HR.JOB_GRADES;
--CREATE TABLE PRODUCTS AS SELECT * FROM HR.PRODUCTS;
--CREATE TABLE SALES AS SELECT * FROM HR.SALES;
--
--ALTER TABLE COUNTRIES ADD CONSTRAINT COUNTRY_C_ID_PK PRIMARY KEY (COUNTRY_ID);
--ALTER TABLE DEPARTMENTS ADD CONSTRAINT DEPT_ID_PK PRIMARY KEY (DEPARTMENT_ID);
--ALTER TABLE EMPLOYEES ADD CONSTRAINT EMP_EMP_ID_PK PRIMARY KEY (EMPLOYEE_ID);
--ALTER TABLE JOBS ADD CONSTRAINT JOB_ID_PK PRIMARY KEY (JOB_ID);
--ALTER TABLE JOB_HISTORY ADD CONSTRAINT JHIST_EMP_ID_ST_DATE_PK PRIMARY KEY (EMPLOYEE_ID, START_DATE);
--ALTER TABLE LOCATIONS ADD CONSTRAINT LOC_ID_PK PRIMARY KEY (LOCATION_ID);
--ALTER TABLE REGIONS ADD CONSTRAINT REG_ID_PK PRIMARY KEY (REGION_ID);
--
--ALTER TABLE COUNTRIES ADD CONSTRAINT COUNTR_REG_FK
--    FOREIGN KEY (REGION_ID) REFERENCES REGIONS (REGION_ID)
--    ON DELETE CASCADE;
--
--ALTER TABLE DEPARTMENTS ADD CONSTRAINT DEPT_LOC_FK
--    FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS (LOCATION_ID)
--    ON DELETE CASCADE;

--ALTER TABLE DEPARTMENTS ADD CONSTRAINT DEPT_MGR_FK
--    FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID)

--ALTER TABLE EMPLOYEES ADD CONSTRAINT EMP_DEPT_FK
--    FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID)

--ALTER TABLE EMPLOYEES ADD CONSTRAINT EMP_JOB_FK
--    FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID)
    
--ALTER TABLE EMPLOYEES ADD CONSTRAINT EMP_MANAGER_FK
--    FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID)

--ALTER TABLE JOB_HISTORY  ADD CONSTRAINT JHIST_DEPT_FK
--    FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID)

--ALTER TABLE JOB_HISTORY ADD CONSTRAINT JHIST_EMP_FK
--    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES  (EMPLOYEE_ID)

--ALTER TABLE JOB_HISTORY ADD CONSTRAINT JHIST_JOB_FK
--    FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID)

--ALTER TABLE LOCATIONS ADD CONSTRAINT LOC_C_ID_FK
--    FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES (COUNTRY_ID)

--ALTER TABLE SALES ADD CONSTRAINT SYS_C00150942
--    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID)

--Zad 3.1
--SELECT last_name || ' ' || salary AS wynagrodzenie
--FROM employees
--WHERE department_id IN (20, 50)
--  AND salary BETWEEN 2000 AND 7000
--ORDER BY last_name;

--Zad 3.2 
--SELECT hire_date, last_name, ${kolumna}
--FROM employees
--WHERE manager_id IS NOT NULL
--  AND EXTRACT(YEAR FROM hire_date) = 2005
--ORDER BY ${kolumna};

--Zad 3.3
--SELECT first_name || ' ' || last_name AS imie_nazwisko,
--       salary,
--       phone_number
--FROM employees
--WHERE last_name LIKE '__e%'
--  AND LOWER(first_name) LIKE '%' || LOWER('${czesc_imienia}') || '%'
--ORDER BY 1 DESC, 2 ASC;

--Zad 3.4
--SELECT first_name,
--       last_name,
--       liczba_miesiecy,
--       CASE
--           WHEN liczba_miesiecy < 150 THEN salary * 0.10
--           WHEN liczba_miesiecy < 200 THEN salary * 0.20
--           ELSE salary * 0.30
--       END AS wysokosc_dodatku
--FROM (
--    SELECT first_name,
--           last_name,
--           salary,
--           ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS liczba_miesiecy
--    FROM employees
--)
--ORDER BY liczba_miesiecy;

--Zad 3.5
--SELECT department_id,
--       SUM(salary) AS suma_zarobkow,
--       ROUND(AVG(salary)) AS srednia_zarobkow
--FROM employees
--WHERE department_id IS NOT NULL
--GROUP BY department_id
--HAVING MIN(salary) > 5000;

--Zad 3.6
--SELECT e.last_name,
--       e.department_id,
--       d.department_name,
--       e.job_id
--FROM employees e
--JOIN departments d ON e.department_id = d.department_id
--JOIN locations l ON d.location_id = l.location_id
--WHERE l.city = 'Toronto';

--Zad 3.7
--SELECT j.first_name || ' ' || j.last_name AS jennifer,
--       w.first_name || ' ' || w.last_name AS wspolpracownik
--FROM employees j
--JOIN employees w ON j.department_id = w.department_id
--                AND j.employee_id <> w.employee_id
--WHERE j.first_name = 'Jennifer'
--ORDER BY j.employee_id, w.last_name;

--Zad 3.8
--SELECT d.department_id, d.department_name
--FROM departments d
--WHERE NOT EXISTS (
--    SELECT 1
--    FROM employees e
--    WHERE e.department_id = d.department_id
--);

--Zad 3.9
--SELECT e.first_name,
--       e.last_name,
--       e.job_id,
--       d.department_name,
--       e.salary,
--       g.GRADE
--FROM employees e
--LEFT JOIN departments d ON e.department_id = d.department_id
--JOIN job_grades g ON e.salary BETWEEN g.MIN_SALARY AND g.MAX_SALARY;

--Zad 3.10
--SELECT first_name, last_name, salary
--FROM employees
--WHERE salary > (SELECT AVG(salary) FROM employees)
--ORDER BY salary DESC;

--Zad 3.11
--SELECT employee_id, first_name, last_name
--FROM employees
--WHERE department_id IN (
--    SELECT department_id
--    FROM employees
--    WHERE LOWER(last_name) LIKE '%u%'
--);

--Zad 3.12
--SELECT employee_id,
--       first_name,
--       last_name,
--       hire_date
--FROM employees
--WHERE SYSDATE - hire_date > (SELECT AVG(SYSDATE - hire_date) FROM employees);

--Zad 3.13
--SELECT d.department_name,
--       COUNT(e.employee_id) AS liczba_pracownikow,
--       ROUND(AVG(e.salary), 2) AS srednie_wynagrodzenie
--FROM departments d
--LEFT JOIN employees e ON e.department_id = d.department_id
--GROUP BY d.department_id, d.department_name
--ORDER BY liczba_pracownikow DESC;

--Zad 3.14
--SELECT first_name, last_name
--FROM employees
--WHERE salary < ALL (
--    SELECT e.salary
--    FROM employees e
--    JOIN departments d ON e.department_id = d.department_id
--    WHERE d.department_name = 'IT'
--);

--Zad 3.14
--SELECT first_name, last_name
--FROM employees
--WHERE salary < ANY (
--    SELECT e.salary
--    FROM employees e
--    JOIN departments d ON e.department_id = d.department_id
--    WHERE d.department_name = 'IT'
--);

--Zad 3.15
--SELECT DISTINCT d.department_id, d.department_name
--FROM departments d
--JOIN employees e ON e.department_id = d.department_id
--WHERE e.salary > (SELECT AVG(salary) FROM employees);

--Zad 3.16
--SELECT j.job_title,
--       ROUND(AVG(e.salary), 2) AS srednie_zarobki
--FROM employees e
--JOIN jobs j ON e.job_id = j.job_id
--GROUP BY j.job_id, j.job_title
--ORDER BY srednie_zarobki DESC
--FETCH FIRST 5 ROWS ONLY;

--Zad 3.17
--SELECT r.region_name,
--       COUNT(DISTINCT c.country_id) AS liczba_krajow,
--       COUNT(e.employee_id) AS liczba_pracownikow
--FROM regions r
--LEFT JOIN countries c ON c.region_id = r.region_id
--LEFT JOIN locations l ON l.country_id = c.country_id
--LEFT JOIN departments d ON d.location_id = l.location_id
--LEFT JOIN employees e ON e.department_id = d.department_id
--GROUP BY r.region_id, r.region_name;

--Zad 3.18
--SELECT e.first_name, e.last_name
--FROM employees e
--JOIN employees m ON e.manager_id = m.employee_id
--WHERE e.salary > m.salary;

--Zad 3.19
--SELECT EXTRACT(MONTH FROM hire_date) AS miesiac,
--       COUNT(*) AS liczba_pracownikow
--FROM employees
--GROUP BY EXTRACT(MONTH FROM hire_date)
--ORDER BY miesiac;

--Zad 3.20
--SELECT d.department_name,
--       ROUND(AVG(e.salary), 2) AS srednie_wynagrodzenie
--FROM departments d
--JOIN employees e ON e.department_id = d.department_id
--GROUP BY d.department_id, d.department_name
--ORDER BY srednie_wynagrodzenie DESC
--FETCH FIRST 3 ROWS ONLY;