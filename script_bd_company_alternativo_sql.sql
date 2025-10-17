-- ===========================================
-- LIMPEZA TOTAL DO SCHEMA
-- ===========================================
DROP SCHEMA IF EXISTS azure_company;
CREATE SCHEMA azure_company;
USE azure_company;

-- ===========================================
-- TABELA: EMPLOYEE
-- ===========================================
CREATE TABLE employee (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR,
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR,
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT NOT NULL DEFAULT 1,
    CONSTRAINT pk_employee PRIMARY KEY (Ssn),
    CONSTRAINT chk_salary_employee CHECK (Salary > 2000.00)
);

ALTER TABLE employee
ADD CONSTRAINT fk_employee_supervisor
FOREIGN KEY (Super_ssn) REFERENCES employee (Ssn)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- ===========================================
-- TABELA: DEPARTAMENT
-- ===========================================
CREATE TABLE departament (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    Dept_create_date DATE,
    CONSTRAINT pk_departament PRIMARY KEY (Dnumber),
    CONSTRAINT unique_departament_name UNIQUE (Dname),
    CONSTRAINT chk_date_dept CHECK (
        Dept_create_date IS NULL
        OR Mgr_start_date IS NULL
        OR Dept_create_date < Mgr_start_date
    ),
    CONSTRAINT fk_departament_manager
        FOREIGN KEY (Mgr_ssn) REFERENCES employee (Ssn)
        ON UPDATE CASCADE
);

-- ===========================================
-- TABELA: DEPT_LOCATIONS
-- ===========================================
CREATE TABLE dept_locations (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dept_locations PRIMARY KEY (Dnumber, Dlocation),
    CONSTRAINT fk_dept_locations
        FOREIGN KEY (Dnumber) REFERENCES departament (Dnumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ===========================================
-- TABELA: PROJECT
-- ===========================================
CREATE TABLE project (
    Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    CONSTRAINT pk_project PRIMARY KEY (Pnumber),
    CONSTRAINT unique_project_name UNIQUE (Pname),
    CONSTRAINT fk_project_departament
        FOREIGN KEY (Dnum) REFERENCES departament (Dnumber)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ===========================================
-- TABELA: WORKS_ON
-- ===========================================
CREATE TABLE works_on (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    CONSTRAINT pk_works_on PRIMARY KEY (Essn, Pno),
    CONSTRAINT fk_works_on_employee
        FOREIGN KEY (Essn) REFERENCES employee (Ssn)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_works_on_project
        FOREIGN KEY (Pno) REFERENCES project (Pnumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ===========================================
-- TABELA: DEPENDENT
-- ===========================================
CREATE TABLE dependent (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR,
    Bdate DATE,
    Relationship VARCHAR(8),
    CONSTRAINT pk_dependent PRIMARY KEY (Essn, Dependent_name),
    CONSTRAINT fk_dependent_employee
        FOREIGN KEY (Essn) REFERENCES employee (Ssn)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ===========================================
-- CONSULTA FINAL DE VERIFICAÇÃO
-- ===========================================
SELECT 
    table_name,
    constraint_name,
    constraint_type
FROM information_schema.table_constraints
WHERE constraint_schema = 'azure_company'
ORDER BY table_name;
