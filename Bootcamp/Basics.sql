CREATE database tutorial;

use tutorial;


---Q.1.Create table Employeedemographics


CREATE TABLE EmployeeDemographics(

EmployeeID INT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Age INT,
Gender VARCHAR(50)

);

--- Q.1.1 Create table EmployeeSalary

CREATE TABLE EmployeeSalary(
EmployeeID INT,
JobTitle VARCHAR(50),
Salary INT
);

SELECT * FROM EmployeeSalary;
SELECT * FROM Employeedemographics;


----- Q.2. Insert Data into tables

INSERT INTO Employeedemographics VALUE
( 1001, 'Jim' , 'Halpert' , 30, 'Male');

INSERT INTO Employeedemographics VALUES
( 1002, 'Pam' , 'Beasely' , 30, 'Female'),
( 1003, 'Dwight' , 'Schrute' , 29, 'Male'),
( 1004, 'Angela' , 'Martin' , 31, 'Female'),
( 1005, 'Toby' , 'Flenderson' , 32, 'Male'),
( 1006, 'Micheal' , 'Scott' , 31, 'Male'),
( 1007, 'Meredith' , 'Palmer' , 32, 'Female'),
( 1008, 'Stanley' , 'Hudson' , 38, 'Male'),
( 1009, 'Kevin' , 'Malone' , 31, 'Male');


---- Q 2.1 Insert into EmployeeSalary table

INSERT INTO EmployeeSalary Values
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000);


use tutorial;

----- Q.3 Select the top columns (Basics of SQL)

SELECT * FROM EmployeeDemographics limit 5;
SELECT DISTINCT Gender from EmployeeDemographics;
SELECT COUNT(LastName) AS last_name from EmployeeDemographics;

Select * FROM EmployeeSalary;
SELECT MAX(salary) as maxsalary FROM EmployeeSalary;
SELECT MIN(salary) as minsalary FROM EmployeeSalary;
SELECT AVG(salary) as avgsalary FROM EmployeeSalary;

---- Very Important
Select * FROM tutorial.employeesalary;


------ Q.4 SQL Basics(Where statement)

SELECT * from EmployeeDemographics;
SELECT * from EmployeeDemographics where firstname='Jim';
SELECT * from EmployeeDemographics where firstname !='Jim';
SELECT * from EmployeeDemographics where Age >= 30;
SELECT * from EmployeeDemographics where Age < 30;
SELECT * from EmployeeDemographics where Age <= 32 OR gender='Male';
SELECT * from EmployeeDemographics where Age <= 32 AND gender='Male';

SELECT * from EmployeeDemographics where Lastname LIKE 'S%';
SELECT * from EmployeeDemographics where Lastname LIKE '%S%';
SELECT * from EmployeeDemographics where Lastname LIKE 'S%O%';

SELECT * from EmployeeDemographics where firstname is NOT NULL ;
SELECT * from EmployeeDemographics where firstname is NULL ;
SELECT * from EmployeeDemographics where firstname In ('Jim' , 'Kevin');


------ Q.5 SQL Basics(Groupby/ orderby statement)

SELECT gender FROM Employeedemographics GROUP BY GENDER;
SELECT gender, COUNT(gender) FROM Employeedemographics GROUP BY GENDER;

SELECT gender, COUNT(gender) FROM Employeedemographics  where age > 32 GROUP BY GENDER;

SELECT gender, COUNT(gender) AS countgender
FROM Employeedemographics  
where age > 31 
GROUP BY GENDER 
ORDER BY gender;


select *from employeedemographics
ORDER BY age, gender;

select *from employeedemographics
ORDER BY 4 Desc, 5 Desc;


