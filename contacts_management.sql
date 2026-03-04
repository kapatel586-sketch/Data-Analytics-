create database contact_management;
use contact_management;
CREATE TABLE Company (
    company_ID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10)
);

INSERT INTO Company (CompanyName, Street, City, State, Zip) VALUES
('Tech Solutions Pvt Ltd', '123 MG Road', 'Ahmedabad', 'GJ', '380015'),
('Skyline Enterprises', '45 Ring Road', 'Surat', 'GJ', '395007'),
('Greenfield Industries', '78 Nehru Street', 'Vadodara', 'GJ', '390001'),
('Bright Future Ltd', '22 CG Road', 'Ahmedabad', 'GJ', '380009'),
('Oceanic Traders', '10 City Light Road', 'Surat', 'GJ', '395001');

select *from Company;

-- 1) Statement to create the Contact table

create table contact (
    contact_id int primary key auto_increment,
    company_id int,
    firstname varchar(45),
    lastname varchar(45),
    street varchar(45),
    city varchar(45),
    state varchar(2),
    zip varchar(10),
    ismain boolean,
    email varchar(45),
    phone varchar(12),
    foreign key (company_id) references company(company_id)
);


insert into contact 
(company_id, firstname, lastname, street, city, state, zip, ismain, email, phone) 
values
(1, 'Rahul', 'Patel', '123 Mg road', 'Ahmedabad', 'Gj', '380015', true, 'rahul.p@gmail.com', '9876543210'),
(1, 'Neha', 'Shah', '123 Mg road', 'Ahmedabad', 'Gj', '380015', false, 'neha.s@gmail.com', '9876543211'),
(2, 'Amit', 'Joshi', '45 Ring road', 'Surat', 'Gj', '395007', true, 'amit.j@gmail.com', '9876543212'),
(3, 'Priya', 'Mehta', '78 Nehru street', 'Vadodara', 'Gj', '390001', true, 'priya.m@gmail.com', '9876543213'),
(4, 'Karan', 'Desai', '22 Cg road', 'Ahmedabad', 'Gj', '380009', false, 'karan.d@gmail.com', '9876543214');

select * from contact;


-- 2) Statement to create the Employee table

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary DECIMAL(10,2),
    Hire_Date DATE,
    Job_Title VARCHAR(25),
    Email VARCHAR(45),
    Phone VARCHAR(12)
);

-- 3) Statement to create the ContactEmployee table HINT: Use DATE as the datatype for ContactDate. It allows you to store the date in this format: YYYY-MM-DD (i.e., ‘2014-03-12’ for March 12, 2014). 

INSERT INTO Employee 
(FirstName, LastName, Salary, Hire_Date, Job_Title, Email, Phone)
VALUES
('Rahul', 'Patel', 45000.00, '2022-06-15', 'Data Analyst', 'rahul.p@gmail.com', '9876543210'),
('Neha', 'Shah', 52000.00, '2021-03-10', 'HR Manager', 'neha.s@gmail.com', '9876543211'),
('Amit', 'Joshi', 60000.00, '2020-11-20', 'Software Engineer', 'amit.j@gmail.com', '9876543212'),
('Priya', 'Mehta', 48000.00, '2023-01-05', 'Accountant', 'priya.m@gmail.com', '9876543213'),
('Karan', 'Desai', 70000.00, '2019-09-18', 'Project Manager', 'karan.d@gmail.com', '9876543214');

SELECT * FROM Employee;

CREATE TABLE Contact_Employee (
    Contact_employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    Contact_ID INT,
    Employee_ID INT,
    Contact_Date DATE,
    Description VARCHAR(100),
    foreign key (Contact_ID) references Contact(Contact_ID),
    foreign key (Employee_ID) references Employee(Employee_ID)
);

INSERT INTO Contact_Employee 
(Contact_ID, Employee_ID, Contact_Date, Description)
VALUES
(1, 1, '2024-01-10', 'Initial project discussion'),
(2, 3, '2024-01-15', 'Requirement gathering meeting'),
(3, 2, '2024-02-05', 'Contract signing'),
(4, 5, '2024-02-20', 'Budget approval discussion'),
(5, 4, '2024-03-01', 'Follow-up meeting');

SELECT * FROM Contact_Employee;

set sql_safe_updates=0;

-- 4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800 
UPDATE Employee SET Phone = '215-555-8800' where employee_id = 2;
SELECT * FROM Employee;

-- 5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” . 
UPDATe company SET companyname = 'Tech solution' where  company_id = 1;
select *from Company;

-- 6) In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement).
DELETE FROM Employee WHERE FirstName = 'Amit' AND LastName = 'Joshi';

-- 7) Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). Run the SQL SELECT query in MySQL Workbench. Copy the results below as well. 

SELECT e.FirstName, e.LastName
FROM Employee e
JOIN Contact_Employee ce ON e.Employee_ID = ce.Employee_ID
JOIN Contact c ON ce.Contact_ID = c.Contact_ID
JOIN Company co ON c.Company_ID = co.Company_ID
WHERE co.CompanyName = 'Tech Solutions Pvt Ltd';

-- 8) What is the significance of “%” and “_” operators in the LIKE statement?
-- % matches any number of characters (e.g., LIKE 'A%' finds anything starting with A).
-- _ matches exactly one single character (e.g., LIKE '_mit' finds "Amit", "Omit", etc.).

-- 9) Explain normalization in the context of databases. 
-- Normalization is basically a way of organizing your database properly so that you don't store the same data in multiple places.

-- 10) What does a JOIN mean in MySQL?
-- A JOIN is basically a way to combine rows from two or more tables based on a related column between them. Like in your database, we joined Employee, Contact_Employee, Contact, and Company together using their ID columns to get meaningful results.

-- 11) DDL, DCL, and DML:
-- DDL (Data Definition Language) — deals with the structure of the database. Commands like `CREATE`, `DROP`, `ALTER`. Like when you created your Company or Contact table.
-- DML (Data Manipulation Language) — deals with the actual data inside tables. Commands like `INSERT`, `UPDATE`, `DELETE`, `SELECT`. Like when you inserted contacts and employees.
-- DCL (Data Control Language) — deals with permissions and access. Commands like `GRANT` and `REVOKE`, basically controlling who can do what in the database.

-- 12) Role of JOIN and common types:
-- JOIN lets you pull data from multiple tables in a single query instead of running separate queries. 
-- Common types are: 
-- INNER JOIN — returns only the rows that have matching values in both tables
-- LEFT JOIN — returns all rows from the left table even if there's no match in the right
-- RIGHT JOIN — opposite of LEFT JOIN
-- FULL JOIN — returns all rows from both tables whether they match or not (not directly supported in MySQL but can be done using UNION)