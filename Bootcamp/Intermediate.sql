use tutorial;

SELECT * FROM employeedemographics;
SELECT * FROM employeesalary;

----- INTERMEDIATE 

--- JOINS -------

SELECT es.EmployeeID,FirstName, LastName,JobTitle,Salary FROM employeedemographics ed
cross JOIN employeesalary es
ON ed.EmployeeID= es.EmployeeID


--- Full join -------

SELECT *
FROM employeedemographics e1
LEFT JOIN employeesalary e2 ON e1.EmployeeID = e2.EmployeeID
UNION
SELECT *
FROM employeedemographics e1
RIGHT JOIN employeesalary  e2 ON e1.EmployeeID = e2.EmployeeID;

---
SELECT ed.EmployeeID,FirstName, LastName,Salary FROM employeedemographics ed
INNER JOIN employeesalary es
ON ed.EmployeeID= es.EmployeeID
WHERE FirstName <> 'Micheal'
ORDER BY Salary DESC;

----
SELECT JobTitle, avg(Salary) FROM employeedemographics ed
cross JOIN employeesalary es
ON ed.EmployeeID= es.EmployeeID
WHERE JobTitle= 'Salesman';


----- UNIONS -------

SELECT * 
FROM employeedemographics
UNION 
SELECT *
FROM employeedemographics;


---------
use tutorial;

CREATE table WarehouseEmployeedemographics(
EmployeeID INT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Age INT,
Gender VARCHAR(50)
);

INSERT INTO warehouseemployeedemographics VALUES
( 1013, 'Daryl' , 'Phibil', NULL, 'Male'),
( 1050, 'Roy' , 'Anderson' , 31, 'Male'),
( 1051, 'Hidetoshi' , 'Hasagawa' , 40, 'Male'),
( 1052, 'Val' , 'Johnson' , 31, 'Female');


----- UNIONS-----

SELECT EmployeeID, Firstname, Age
FROM Employeedemographics
UNION
SELECT EmployeeID, Jobtitle, Salary
FROM  EmployeeSalary
ORDER BY EmployeeID;

--- NB: This code above  still works because columns are similar but literally it is a mistake.ALTER




----- CASE STATEMENT -----
SELECT FirstName, LastName, Age,
(CASE 
	WHEN Age > 30 THEN 'Mid'
	ELSE 'Young'
END) as description
FROM employeedemographics
WHERE age IS NOT NULL
ORDER BY Age;



SELECT FirstName, LastName, Age,
CASE 
	WHEN Age > 30 THEN 'Mid'
    WHEN Age BETWEEN 18 and 29 THEN 'Young'
	ELSE 'old'
END
FROM employeedemographics
WHERE age IS NOT NULL
ORDER BY Age;



------
SELECT * 
FROM employeedemographics e1
JOIN employeesalary e2
ON e1.EmployeeID= e2.EmployeeID



-----
SELECT FirstName, LastName, Jobtitle, Salary,
(CASE 
	WHEN Jobtitle = 'Salesman' THEN Salary + (Salary  * .10)
    WHEN Jobtitle = 'Accountant' THEN Salary + (Salary  * .05)
	WHEN Jobtitle = 'HR' THEN Salary + (Salary  * .01)
    ELSE Salary + (Salary  * .03)
END) as final_salary
FROM employeedemographics e1
JOIN employeeSalary e2
ON e1.EmployeeID= e2.EmployeeID;




--------HAVING 	Clause-----

SELECT Jobtitle, Count(Jobtitle) as total
FROM employeedemographics e1
JOIN employeesalary e2
ON e1.EmployeeID= e2.EmployeeID
GROUP BY Jobtitle
HAVING count(Jobtitle) >1;
--- Agg stratement cannot be used in a where statement


SELECT Jobtitle, AVG(Salary)
FROM employeedemographics e1
JOIN employeesalary e2
ON e1.EmployeeID= e2.EmployeeID
GROUP BY Jobtitle
HAVING AVG(Salary) >45000
ORDER BY AVG(Salary);



-----Update and DELETE Statements-----

select * from warehouseemployeedemographics;

SET SQL_SAFE_UPDATES = 0;

UPDATE warehouseemployeedemographics
SET Age = 31, Gender= 'Female'
WHERE FirstName= 'Daryl' AND LastName='Phibil';

-- use delete very cautiously---- see B4 doing----




---- Aliasing----

SELECT * from employeedemographics;
SELECT FirstName AS f_name from employeedemographics;

SELECT AVG(Age) AS average from employeedemographics;
SELECT DEMO.firstName FROM employeedemographics AS demo;

SELECT DEMO.EmployeeID, sal.Salary 
FROM employeedemographics AS demo
JOIN employeesalary as sal
ON demo.EmployeeID= sal.EmployeeID;


SELECT DEMO.EmployeeID, demo.FirstName, Sal.JobTitle, Ware.Age
FROM employeedemographics demo
LEFT JOIN employeesalary sal
ON demo.EmployeeID= sal.EmployeeID
LEFT JOIN warehouseemployeedemographics ware
ON demo.EmployeeID= ware.EmployeeID;





-------PARTITION CLAUSE-----

SELECT * FROM employeesalary


SELECT FirstName, LastName, Gender, Salary,
COUNT(GENDER) OVER (PARTITION BY GENDER) AS Total_gender
FROM employeedemographics e1
JOIN employeesalary e2
ON e1.EmployeeID= e2.EmployeeID



---
SELECT FirstName, LastName, Gender, Salary, COUNT(GENDER)  
FROM employeedemographics e1
JOIN employeesalary e2
ON e1.EmployeeID= e2.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary

---
SELECT  Gender,  COUNT(GENDER)  
FROM employeedemographics e1
JOIN employeesalary e2
ON e1.EmployeeID= e2.EmployeeID
GROUP BY  Gender