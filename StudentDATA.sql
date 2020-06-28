CREATE TABLE employees
(employee_ID NUMBER(3),
First_Name VARCHAR2(30),
Last_Name VARCHAR2(30),
Dept_Code CHAR(3),
Hire_Date date,
Credit_Limit NUMBER(6),
Phone_Ext CHAR(4),
Manager_id CHAR(3) );

insert into Employees values (201, 'Susan', 'Brown', 'Exe', To_Date('01-Jun-1998','DD-Mon-YYYY'), 30, '3484', null);
insert into Employees values (202, 'Jim', 'Kern', 'Sal', To_Date('16-Aug-1999','DD-Mon-YYYY'), 25, '8722', 201);
insert into Employees values (203, 'Martha', 'Woods', 'Shp', To_Date('02-Feb-2004','DD-Mon-YYYY'), 25, '7591', 201);	
insert into Employees values (204, 'Ellen', 'Owens', 'Sal', To_Date('01-Jul-2003','DD-Mon-YYYY'), 15, '6830', 202);
insert into Employees values (205, 'Henry', 'Perkins', 'Sal', To_Date('01-Mar-2000','DD-Mon-YYYY'), 25, '5286', 202);
insert into Employees values (206, 'Carol', 'Rose', 'Act', null, null, null, null);
insert into Employees values (207, 'Dan', 'Smith', 'Shp', To_Date('01-Dec-2004','DD-Mon-YYYY'), 25, '2259', 203);
insert into Employees values (208, 'Fred', 'Campbell', 'Shp', To_Date('01-April-2003','DD-Mon-YYYY'), 25, '1752', 203);
insert into Employees values (209, 'Paula', 'Jacobs', 'Mkt', To_Date('17-Mar-1999','DD-Mon-YYYY'), 15, '3357', 201);
insert into Employees values (210, 'Nancy', 'Hoffman', 'Sal', To_Date('16-Feb-2004','DD-Mon-YYYY'), 25, '2974', 203);
------------------------------------------


-- Question 01 --
INSERT INTO employees VALUES (211, 'JOHN', 'SMITH', 'Sal', To_Date('12-Sep-2011','DD-Mon-YYYY'), NULL, NULL, NULL); 

-- Question 02 --
INSERT INTO employees VALUES (212, 'PAUL', 'ADAM', 'Mkt', To_Date('15-Aug-2011', 'DD-Mon-YYYY'), 15.00 , NULL, 202); 

-- Question 03 --
DELETE FROM employees WHERE employee_ID = 205;

-- Question 04 --
DELETE FROM employees WHERE Last_Name = 'Perkins'; 

-- Question 05 --
DELETE FROM employees WHERE Dept_Code = 'Shp';

-- Question 06 --
UPDATE employees SET Credit_Limit = Credit_Limit + 5 WHERE employee_ID = 210;

-- Question 07 --
UPDATE employees SET Credit_Limit = Credit_Limit + 10 ;

-- Question 08 --
UPDATE employees SET Credit_Limit = Credit_Limit + 10 WHERE Dept_Code = 'Act';

-- Question 09 --
UPDATE employees SET Phone_Ext = 2345 WHERE Last_Name = 'Campbell' and First_Name = 'Fred';

-- Question 10 --
UPDATE employees SET Dept_Code = 'Exe' WHERE First_Name = 'Jim' and Last_Name = 'Kern';
