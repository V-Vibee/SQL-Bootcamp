------ADVANCED----

USE TUTORIAL;

----- COMMON Table expression------

WITH CTE_Employee as (
SELECT FirstName, LastName, Gender, Salary,
COUNT(gender) OVER(PARTITION BY Gender) AS TotalGender,
AVG(Salary) OVER(PARTITION BY Gender) AS AvgSalary
FROM employeedemographics e1
JOIN employeesalary e2
ON e1.EmployeeID= e2.EmployeeID
WHERE salary > '45000')
SELECT * FROM CTE_Employee



----TEMP TABLES----

CREATE TEMPORARY TABLE temp_Employee (
    EmployeeID INT,
    JobTitle VARCHAR(100),
    Salary INT
);

SELECT * FROM temp_Employee

INSERT INTO temp_Employee VALUE
('1001', 'HR', '45000')

---Another way

INSERT INTO temp_Employee
SELECT * FROM employeesalary;

CREATE TEMPORARY TABLE temp_Employee2(
    JobTitle VARCHAR(50),
    EmployeesperJob INT,
    AverageAge INT,
    AVERAGEsALARY INT
);


INSERT INTO temp_Employee2(
SELECT  JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM employeedemographics e1
JOIN employeesalary e2
ON e1.EmployeeID= e2.EmployeeID
GROUP BY  JobTitle
);

use tutorial;
SELECT * from temp_Employee2;




------- String Fuction plus Use cases---
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

INSERT INTO EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')


---------Use TRIM, LTRIM, RTRIM-------

SELECT EmployeeID, TRIM(EmployeeID) AS Trimmed_id
From EmployeeErrors


SELECT EmployeeID, LTRIM(EmployeeID) AS Trimmed_id
From EmployeeErrors


SELECT EmployeeID, RTRIM(EmployeeID) AS Trimmed_id
From EmployeeErrors



----------USING REPLACE-------
SELECT * FROM EmployeeErrors



Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors





---------USING SUBSTRING-------


SELECT SUBSTRING(firstName, 1,3)
FROM EmployeeErrors


SELECT er.Firstname, de.Firstname
FROM EmployeeErrors er
JOIN employeedemographics de
ON er.Firstname= de.Firstname


----Another way/ Fuzzy match

SELECT er.Firstname,SUBSTRING(er.Firstname,1,3), de.Firstname,SUBSTRING(de.Firstname,1,3)
FROM EmployeeErrors er
JOIN employeedemographics de
ON SUBSTRING(er.Firstname,1,3)= SUBSTRING(de.Firstname,1,3)

---- GENDER
----LAST NAME
----- AGE
----- DOB
----- TO match  this is the best way using SUBSTRING.



-----USING UPPER & lOWER

SELECT FirstName, LOWER(Firstname)
FROM EmployeeErrors

SELECT FirstName, UPPER(Firstname)
FROM EmployeeErrors



-----STORED PROCEDURES/USE CASES-----

DELIMITER //

CREATE PROCEDURE TEST()
BEGIN
    SELECT * FROM employeedemographics;
END //

DELIMITER ;




------ SUBQUERIES----

SELECT * FROM EmployeeSalary

SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS average
FROM EmployeeSalary

----DO WITH PARTITION CLAUSE

SELECT EmployeeID, Salary, AVG(Salary) OVER()AS average
FROM EmployeeSalary

SELECT EmployeeID, Salary, AVG(Salary) AS average
FROM EmployeeSalary
GROUP BY EmployeeId, Salary
ORDER BY 1,2


--------Subquery in From statement
SELECT a.EmployeeID, Average
FROM (SELECT EmployeeID, Salary, AVG(Salary) over() AS Average FROM EmployeeSalary) a


-----Subquery in where statement----
SELECT EmployeeID, JobTitle, Salary 
FROM employeesalary
WHERE EmployeeID in (SELECT EmployeeID FROM employeedemographics WHERE Age > 30)