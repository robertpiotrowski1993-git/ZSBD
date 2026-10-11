-- Pkt 1
CREATE TABLE regions (
    region_id NUMBER NOT NULL,
    region_name VARCHAR2(25),
    CONSTRAINT regions_pk PRIMARY KEY (region_id)
);

CREATE TABLE countries (
    country_id NUMBER NOT NULL,
    country_name VARCHAR2(60),
    CONSTRAINT countries_pk PRIMARY KEY (country_id)
);

CREATE TABLE locations (
    location_id NUMBER NOT NULL,
    street_address VARCHAR2(40),
    postal_code VARCHAR2(12),
    city VARCHAR2(30) NOT NULL,
    state_province VARCHAR2(25),
    CONSTRAINT locations_pk PRIMARY KEY (location_id)
);

CREATE TABLE jobs (
    job_id NUMBER NOT NULL,
    job_title VARCHAR2(35) NOT NULL,
    min_salary NUMBER(6),
    CONSTRAINT jobs_pk PRIMARY KEY (job_id)
);

CREATE TABLE departments (
    department_id NUMBER NOT NULL,
    department_name VARCHAR2(30) NOT NULL,
    CONSTRAINT departments_pk PRIMARY KEY (department_id)
);

CREATE TABLE employees (
    employee_id NUMBER NOT NULL,
    first_name VARCHAR2(20),
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(25) NOT NULL,
    phone_number VARCHAR2(20),
    hire_date DATE NOT NULL,
    job_id NUMBER NOT NULL,
    salary NUMBER(8,2),
    commission_pct NUMBER(2,2),
    CONSTRAINT employees_pk PRIMARY KEY (employee_id),
    CONSTRAINT employees_email_uk UNIQUE (email)
);

CREATE TABLE job_history (
    employee_id NUMBER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id NUMBER NOT NULL,
    CONSTRAINT job_history_pk PRIMARY KEY (employee_id, start_date)
);

ALTER TABLE countries ADD (region_id NUMBER);
ALTER TABLE locations ADD (country_id NUMBER);
ALTER TABLE jobs ADD (max_salary NUMBER(6));
ALTER TABLE departments ADD (manager_id NUMBER);
ALTER TABLE departments ADD (location_id NUMBER);
ALTER TABLE employees ADD (manager_id NUMBER);
ALTER TABLE employees ADD (department_id NUMBER);
ALTER TABLE job_history ADD (department_id NUMBER);

ALTER TABLE countries
    ADD CONSTRAINT countries_region_fk
    FOREIGN KEY (region_id) REFERENCES regions (region_id);

ALTER TABLE locations
    ADD CONSTRAINT locations_country_fk
    FOREIGN KEY (country_id) REFERENCES countries (country_id);

ALTER TABLE departments
    ADD CONSTRAINT departments_location_fk
    FOREIGN KEY (location_id) REFERENCES locations (location_id);

ALTER TABLE employees
    ADD CONSTRAINT employees_job_fk
    FOREIGN KEY (job_id) REFERENCES jobs (job_id);

ALTER TABLE employees
    ADD CONSTRAINT employees_department_fk
    FOREIGN KEY (department_id) REFERENCES departments (department_id);

ALTER TABLE employees
    ADD CONSTRAINT employees_manager_fk
    FOREIGN KEY (manager_id) REFERENCES employees (employee_id);

ALTER TABLE departments
    ADD CONSTRAINT departments_manager_fk
    FOREIGN KEY (manager_id) REFERENCES employees (employee_id);

ALTER TABLE job_history
    ADD CONSTRAINT job_history_employee_fk
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id);

ALTER TABLE job_history
    ADD CONSTRAINT job_history_job_fk
    FOREIGN KEY (job_id) REFERENCES jobs (job_id);

ALTER TABLE job_history
    ADD CONSTRAINT job_history_department_fk
    FOREIGN KEY (department_id) REFERENCES departments (department_id);

ALTER TABLE jobs
    ADD CONSTRAINT jobs_salary_range_ck
    CHECK (max_salary - min_salary >= 2000);

-- Pkt 2
INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES (1, 'Asystent administracyjny', 3000, 6000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES (2, 'Przedstawiciel handlowy', 4000, 9000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES (3, 'Programista', 4000, 10000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES (4, 'Magazynier', 2000, 5000);

COMMIT;

-- Pkt 3
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (1, 'Tomasz', 'Kamiński', 'TKAMINSKI', '515123427', DATE '2020-01-15', 1, 5000, NULL, NULL, NULL);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (4, 'Katarzyna', 'Lewandowska', 'KLEWANDOWSKA', '665123570', DATE '2020-06-01', 4, 3500, NULL, 1, NULL);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (2, 'Tomasz', 'Dąbrowski', 'TDABROWSKI', '515124568', DATE '2021-03-10', 4, 3000, NULL, 4, NULL);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (3, 'Agnieszka', 'Szymańska', 'ASZYMANSKA', '7511234569', DATE '2021-09-20', 1, 4200, NULL, 4, NULL);

COMMIT;

-- Pkt 4
UPDATE employees
SET manager_id = 1
WHERE employee_id IN (2, 3);

COMMIT;

-- Pkt 5
UPDATE jobs
SET min_salary = min_salary + 500,
    max_salary = max_salary + 500
WHERE LOWER(job_title) LIKE '%b%'
   OR LOWER(job_title) LIKE '%s%';

COMMIT;

-- Pkt 6
DELETE FROM jobs
WHERE max_salary > 9000;

COMMIT;

-- Pkt 7
DROP TABLE job_history;

SELECT object_name, original_name, droptime
FROM user_recyclebin;

FLASHBACK TABLE job_history TO BEFORE DROP;

SELECT * FROM job_history;