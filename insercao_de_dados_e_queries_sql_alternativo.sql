USE azure_company;

-- =============================================================
-- 1️⃣ EMPLOYEE (sem super_ssn primeiro)
-- =============================================================
INSERT INTO employee(fname, minit, lname, ssn, bdate, address, sex, salary, super_ssn, dno) VALUES
('John', 'B', 'Smith', '123456789', '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, NULL, 5),
('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, NULL, 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, NULL, 4),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000, NULL, 4),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975-Fire-Oak-Humble-TX', 'M', 38000, NULL, 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631-Rice-Houston-TX', 'F', 25000, NULL, 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000, NULL, 4),
('James', 'E', 'Borg', '888665555', '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, NULL, 1);

-- =============================================================
-- 2️⃣ DEPARTAMENT (mgr_ssn agora existe)
-- =============================================================
INSERT INTO departament(dname, dnumber, mgr_ssn, mgr_start_date) VALUES
('Research', 5, '333445555', '1988-05-22'),
('Administration', 4, '987654321', '1995-01-01'),
('Headquarters', 1, '888665555', '1981-06-19');

-- =============================================================
-- 3️⃣ Atualizando super_ssn agora que todos os employees existem
-- =============================================================
UPDATE employee SET super_ssn='333445555' WHERE ssn='123456789';
UPDATE employee SET super_ssn='888665555' WHERE ssn='333445555';
UPDATE employee SET super_ssn='987654321' WHERE ssn='999887777';
UPDATE employee SET super_ssn='888665555' WHERE ssn='987654321';
UPDATE employee SET super_ssn='333445555' WHERE ssn='666884444';
UPDATE employee SET super_ssn='333445555' WHERE ssn='453453453';
UPDATE employee SET super_ssn='987654321' WHERE ssn='987987987';
UPDATE employee SET super_ssn=NULL WHERE ssn='888665555';

-- =============================================================
-- 4️⃣ DEPT_LOCATIONS
-- =============================================================
INSERT INTO dept_locations(dnumber, dlocation) VALUES
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

-- =============================================================
-- 5️⃣ PROJECT
-- =============================================================
INSERT INTO project(pname, pnumber, plocation, dnum) VALUES
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

-- =============================================================
-- 6️⃣ WORKS_ON
-- =============================================================
INSERT INTO works_on(essn, pno, hours) VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, 0.0);

-- =============================================================
-- 7️⃣ DEPENDENT
-- =============================================================
INSERT INTO dependent(essn, dependent_name, sex, bdate, relationship) VALUES
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'),
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'),
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');


-- =============================================================
-- 1️⃣ Selecionar todos os funcionários
-- =============================================================
SELECT * FROM employee;

-- =============================================================
-- 2️⃣ Contagem de dependentes por funcionário
-- =============================================================
SELECT e.Ssn, COUNT(d.Essn) AS total_dependents
FROM employee e
LEFT JOIN dependent d ON e.Ssn = d.Essn
GROUP BY e.Ssn;

-- =============================================================
-- 3️⃣ Selecionar todos os dependentes
-- =============================================================
SELECT * FROM dependent;

-- =============================================================
-- 4️⃣ Recuperar informações de John B Smith
-- =============================================================
SELECT Bdate, Address 
FROM employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

-- =============================================================
-- 5️⃣ Selecionar departamento Research
-- =============================================================
SELECT * FROM departament WHERE Dname = 'Research';

-- =============================================================
-- 6️⃣ Funcionários do departamento Research
-- =============================================================
SELECT e.Fname, e.Lname, e.Address
FROM employee e
JOIN departament d ON e.Dno = d.Dnumber
WHERE d.Dname = 'Research';

-- =============================================================
-- 7️⃣ Todos os projetos
-- =============================================================
SELECT * FROM project;

-- =============================================================
-- 8️⃣ Departamentos presentes em Stafford
-- =============================================================
SELECT DISTINCT d.Dname AS Department, d.Mgr_ssn AS Manager
FROM departament d
JOIN dept_locations l ON d.Dnumber = l.Dnumber
WHERE l.Dlocation = 'Stafford';

-- =============================================================
-- 9️⃣ Departamentos com nome do gerente concatenado
-- =============================================================
SELECT DISTINCT d.Dname AS Department, CONCAT(e.Fname, ' ', e.Lname) AS Manager
FROM departament d
JOIN dept_locations l ON d.Dnumber = l.Dnumber
JOIN employee e ON d.Mgr_ssn = e.Ssn
WHERE l.Dlocation = 'Stafford';

-- =============================================================
-- 10️⃣ Projetos localizados em Stafford
-- =============================================================
SELECT p.*
FROM project p
JOIN departament d ON p.Dnum = d.Dnumber
WHERE p.Plocation = 'Stafford';

-- =============================================================
-- 11️⃣ Departamentos e projetos em Stafford
-- =============================================================
SELECT p.Pnumber, p.Dnum, e.Lname, e.Address, e.Bdate
FROM project p
JOIN departament d ON p.Dnum = d.Dnumber
JOIN employee e ON d.Mgr_ssn = e.Ssn
WHERE p.Plocation = 'Stafford';

-- =============================================================
-- 12️⃣ Funcionários em departamentos específicos (3,6,9)
-- =============================================================
SELECT * FROM employee
WHERE Dno IN (3,6,9); -- Atenção: pode retornar vazio se não existirem esses Dno

-- =============================================================
-- 13️⃣ INSS de funcionários
-- =============================================================
SELECT Fname, Lname, Salary, ROUND(Salary*0.011, 2) AS INSS
FROM employee;

-- =============================================================
-- 14️⃣ Aumento de salário para gerentes de projeto ProductX
-- =============================================================
SELECT e.Fname, e.Lname, 1.1 * e.Salary AS increased_sal
FROM employee e
JOIN works_on w ON e.Ssn = w.Essn
JOIN project p ON w.Pno = p.Pnumber
WHERE p.Pname = 'ProductX';

-- =============================================================
-- 15️⃣ Departamentos com gerente concatenado
-- =============================================================
SELECT d.Dname AS Department, CONCAT(e.Fname, ' ', e.Lname) AS Manager
FROM departament d
JOIN dept_locations l ON d.Dnumber = l.Dnumber
JOIN employee e ON d.Mgr_ssn = e.Ssn;

-- =============================================================
-- 16️⃣ Funcionários que trabalham no departamento Research
-- =============================================================
SELECT e.Fname, e.Lname, e.Address
FROM employee e
JOIN departament d ON e.Dno = d.Dnumber
WHERE d.Dname = 'Research';


