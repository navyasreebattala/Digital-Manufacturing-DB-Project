create database sql_project;
use sql_project;
CREATE TABLE Machine(
    Machine_ID INT PRIMARY KEY,
    Machine_Name VARCHAR(50),
    Machine_Type VARCHAR(30),
    Purchase_Date DATE,
    Last_Maintenance DATE,
    Statuses VARCHAR(20)
);
CREATE TABLE Operator (
    Operator_ID INT PRIMARY KEY,
    Operator_Name VARCHAR(50),
    Shift VARCHAR(20),
    Experience_Years INT,
    Assigned_Machine INT,
    FOREIGN KEY (Assigned_Machine) REFERENCES Machine(Machine_ID)
);
CREATE TABLE Product_Log (
    Product_ID INT PRIMARY KEY,
    Machine_ID INT,
    Operator_ID INT,
    Product_Name VARCHAR(50),
    Quantity_Produced INT,
    Production_Date DATE,
    FOREIGN KEY (Machine_ID) REFERENCES Machine(Machine_ID),
    FOREIGN KEY (Operator_ID) REFERENCES Operator(Operator_ID)
);
CREATE TABLE Product_Quality (
    Quality_ID INT PRIMARY KEY,
    Product_ID INT,
    Inspection_Date DATE,
    Defective_Units INT,
    Quality_Score DECIMAL(4,2),
    Inspector_Name VARCHAR(50),
    FOREIGN KEY (Product_ID) REFERENCES Product_Log(Product_ID)
);


INSERT INTO Machine VALUES
(101, 'Lathe-01', 'Lathe', '2020-02-15', '2025-09-10', 'Running'),
(102, 'CNC-01', 'CNC', '2021-05-20', '2025-10-01', 'Running'),
(103, 'Milling-01', 'Milling', '2019-11-01', '2025-08-15', 'Under Maintenance'),
(104, 'Drill-01', 'Drilling', '2022-04-18', '2025-09-28', 'Idle'),
(105, 'CNC-02', 'CNC', '2023-01-05', '2025-10-15', 'Running');


INSERT INTO Operator VALUES
(201, 'Ravi Kumar', 'Morning', 5, 101),
(202, 'Sneha Reddy', 'Evening', 3, 102),
(203, 'Arjun Mehta', 'Night', 7, 103),
(204, 'Priya Das', 'Morning', 2, 104),
(205, 'Rahul Verma', 'Evening', 4, 105);

INSERT INTO Product_Log VALUES
(301, 101, 201, 'Gear Shaft', 120, '2025-10-20'),
(302, 102, 202, 'Engine Cover', 95, '2025-10-21'),
(303, 103, 203, 'Rotor Blade', 70, '2025-10-21'),
(304, 104, 204, 'Bearing Cap', 110, '2025-10-22'),
(305, 105, 205, 'Valve Plate', 130, '2025-10-23');

INSERT INTO Product_Quality VALUES
(501, 301, '2025-10-20', 5, 95.8, 'Haritha'),
(502, 302, '2025-10-21', 8, 91.6, 'Ramesh'),
(503, 303, '2025-10-21', 3, 97.5, 'Vani'),
(504, 304, '2025-10-22', 7, 93.4, 'Kavita'),
(505, 305, '2025-10-23', 4, 96.9, 'Haritha');

#sql quaries about the project
# 1. Display all machines
SELECT * FROM Machine;

# 2. Display all operators
SELECT * FROM Operator;

# 3. Display all products
SELECT * FROM Product_Log;

# 4. Display all maintenance logs
SELECT * FROM Maintenance_Log;

# 5. Display all product quality records
SELECT * FROM Product_Quality;

# 6. Show machine name and status
SELECT Machine_Name, Status FROM Machine;

#7. List operators who work in the Morning shift
SELECT Operator_Name FROM Operator WHERE Shift = 'Morning';

# 8. Show machines purchased after 2020
SELECT * FROM Machine WHERE Purchase_Date > '2020-12-31';

# 9. Count total number of machines
SELECT COUNT(*) AS Total_Machines FROM Machine;

# 10. Count total operators
SELECT COUNT(*) AS Total_Operators FROM Operator;

# 11. Find total quantity produced
SELECT SUM(Quantity_Produced) AS Total_Production FROM Product_Log;

# 12. Find average quantity produced
SELECT AVG(Quantity_Produced) AS Avg_Production FROM Product_Log;

# 13. Find maximum production quantity
SELECT MAX(Quantity_Produced) AS Max_Production FROM Product_Log;

# 14. Find minimum production quantity
SELECT MIN(Quantity_Produced) AS Min_Production FROM Product_Log;

# 15. Show product name and its production date
SELECT Product_Name, Production_Date FROM Product_Log;

# 16. Show operator name and their assigned machine
SELECT o.Operator_Name, m.Machine_Name
FROM Operator o
JOIN Machine m ON o.Assigned_Machine = m.Machine_ID;

# 17. Show products produced by each operator
SELECT o.Operator_Name, p.Product_Name, p.Quantity_Produced
FROM Operator o
JOIN Product_Log p ON o.Operator_ID = p.Operator_ID;

#18. Show maintenance details of each machine
SELECT m.Machine_Name, ml.Maintenance_Type, ml.Maintenance_Date
FROM Machine m
JOIN Maintenance_Log ml ON m.Machine_ID = ml.Machine_ID;

# 19. Show inspector name and product quality score
SELECT pq.Inspector_Name, p.Product_Name, pq.Quality_Score
FROM Product_Quality pq
JOIN Product_Log p ON pq.Product_ID = p.Product_ID;

# 20. Show all products with defects greater than 5
SELECT * FROM Product_Quality WHERE Defective_Units > 5;

# 21. Find all products produced between two dates
SELECT * FROM Product_Log
WHERE Production_Date BETWEEN '2025-10-20' AND '2025-10-23';

# 22. Count number of maintenance activities per machine
SELECT Machine_ID, COUNT(*) AS Total_Maintenance
FROM Maintenance_Log
GROUP BY Machine_ID;

# 23. Show average quality score of all products
SELECT AVG(Quality_Score) AS Avg_Quality FROM Product_Quality;

# 24. Show total maintenance duration
SELECT SUM(Duration_Hours) AS Total_Maintenance_Hours FROM Maintenance_Log;

# 25. Find operator with experience more than 4 years
SELECT * FROM Operator WHERE Experience_Years > 4;

# 26. Sort products by quantity produced (descending)
SELECT * FROM Product_Log ORDER BY Quantity_Produced DESC;

# 27. Sort operators by experience (highest first)
SELECT * FROM Operator ORDER BY Experience_Years DESC;

# 28. Show distinct maintenance types
SELECT DISTINCT Maintenance_Type FROM Maintenance_Log;

# 29. Find machines currently under maintenance
SELECT * FROM Machine WHERE Status = 'Under Maintenance';

# 30. Show machine name, operator name, and product name together
SELECT m.Machine_Name, o.Operator_Name, p.Product_Name
FROM Machine m
JOIN Operator o ON m.Machine_ID = o.Assigned_Machine
JOIN Product_Log p ON o.Operator_ID = p.Operator_ID;