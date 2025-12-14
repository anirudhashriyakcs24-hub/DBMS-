create database bank_AnirudhaShriyak;
use bank_AnirudhaShriyak;
CREATE TABLE Branch (
    BranchName VARCHAR(50) PRIMARY KEY,
    BranchCity VARCHAR(50),
    Assets INT
);

CREATE TABLE BankAccount (
    AccNo INT PRIMARY KEY,
    BranchName VARCHAR(50),
    Balance INT,
    FOREIGN KEY (BranchName) REFERENCES Branch(BranchName)
);
CREATE TABLE BankCustomer (
    CustomerName VARCHAR(50) PRIMARY KEY,
    CustomerStreet VARCHAR(50),
    CustomerCity VARCHAR(50)
);
CREATE TABLE Depositer (
    CustomerName VARCHAR(50),
    AccNo INT,
    PRIMARY KEY (CustomerName, AccNo),
    FOREIGN KEY (CustomerName) REFERENCES BankCustomer(CustomerName),
    FOREIGN KEY (AccNo) REFERENCES BankAccount(AccNo)
);
CREATE TABLE Loan (
    LoanNumber INT PRIMARY KEY,
    BranchName VARCHAR(50),
    Amount INT,
    FOREIGN KEY (BranchName) REFERENCES Branch(BranchName)
);
INSERT INTO Branch VALUES
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);
INSERT INTO BankAccount VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000),
(6, 'SBI_ShivajiRoad', 3000),
(8, 'SBI_ResidencyRoad', 5000),
(9, 'SBI_ParlimentRoad', 4000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);
INSERT INTO BankCustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannerghatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikhil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');
INSERT INTO Depositer VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikhil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikhil', 9),
('Dinesh', 10),
('Nikhil', 11); 
INSERT INTO Loan VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);
SELECT
    BranchName,
    (Assets / 100000.0) AS "Assets in Lakhs"
FROM Branch;
SELECT D.CustomerName, B.BranchName, COUNT(*) AS No_of_Accounts
FROM Depositer D
JOIN BankAccount B ON D.AccNo = B.AccNo
GROUP BY D.CustomerName, B.BranchName
HAVING COUNT(*) >= 2;                                                                                                                 
CREATE VIEW BranchLoanSum AS
SELECT
    BranchName,
    SUM(Amount) AS Total_Loan_Amount
FROM Loan
GROUP BY BranchName;
SELECT * FROM BranchLoanSum; 
SELECT BranchName
FROM Branch
WHERE BranchCity = 'Delhi';

SELECT D.CustomerName
FROM Depositer D
JOIN BankAccount B ON D.AccNo = B.AccNo
WHERE B.BranchName IN (
    SELECT BranchName FROM Branch WHERE BranchCity = 'Delhi'
)
GROUP BY D.CustomerName
HAVING COUNT(DISTINCT B.BranchName) = (
    SELECT COUNT(*) FROM Branch WHERE BranchCity = 'Delhi'
);
