CREATE DATABASE IF NOT EXISTS supplier_AnirudhaShriyak_db;
USE supplier_AnirudhaShriyak_db;

CREATE TABLE Supplier (
    sid INT PRIMARY KEY,
    sname VARCHAR(30),
    city VARCHAR(30)
);

CREATE TABLE Parts (
    pid INT PRIMARY KEY,
    pname VARCHAR(30),
    color VARCHAR(20)
);

CREATE TABLE Catalog (
    sid INT,
    pid INT,
    cost DECIMAL(8,2),
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES Supplier(sid),
    FOREIGN KEY (pid) REFERENCES Parts(pid)
);

INSERT INTO Supplier VALUES (10001, 'Acme Widget', 'Bangalore'),(10002, 'Johns', 'Kolkata'),
(10003, 'Vimal', 'Mumbai'),(10004, 'Reliance', 'Delhi'),
(10005, 'Mahindra', 'Mumbai');
INSERT INTO Parts VALUES (20001, 'Book', 'Red'),(20002, 'Pen', 'Red'),
(20003, 'Pencil', 'Green'),(20004, 'Mobile', 'Green'),
(20005, 'Charger', 'Black');
INSERT INTO Catalog VALUES (10001, 20001, 10),
(10001, 20002, 10),(10001, 20003, 30),
(10001, 20004, 10),(10001, 20005, 10),
(10002, 20001, 10),(10002, 20002, 20),
(10003, 20003, 30),(10004, 20003, 40);
SELECT * FROM Supplier;	
SELECT * FROM Parts;
SELECT * FROM Catalog;

-- (iii) Find the pnames of parts for which there is some supplier
SELECT DISTINCT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid;

-- (iv) Find the snames of suppliers who supply every part
SELECT s.sname
FROM Supplier s
JOIN Catalog c ON s.sid = c.sid
GROUP BY s.sname
HAVING COUNT(DISTINCT c.pid) = (SELECT COUNT(*) FROM Parts);    

-- (v) Find the snames of suppliers who supply every red part
SELECT s.sname
FROM Supplier s
JOIN Catalog c ON s.sid = c.sid
JOIN Parts p ON c.pid = p.pid
WHERE p.color = 'Red'
GROUP BY s.sname
HAVING COUNT(DISTINCT p.pid) = (
    SELECT COUNT(*) FROM Parts WHERE color = 'Red'
);

-- (vi) Find the pnames of parts supplied by Acme Widget and by no one else
SELECT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid
JOIN Supplier s ON s.sid = c.sid
group by p.pname having count( distinct case when s.sname='Acme Widget' then s.sid end)=1 and count( distinct s.sid)=1; 

-- (vii) Find the sids of suppliers who charge more for some part
-- than the average cost of that part (across all suppliers)
SELECT DISTINCT c.sid
FROM Catalog c
WHERE c.cost > (
    SELECT AVG(c2.cost)
    FROM Catalog c2
    WHERE c2.pid = c.pid
);

-- (viii) For each part, find the sname of the supplier who charges the most
SELECT p.pname, s.sname, c.cost
FROM Catalog c
JOIN Supplier s ON c.sid = s.sid
JOIN Parts p ON c.pid = p.pid
WHERE c.cost = (
    SELECT MAX(c2.cost)
    FROM Catalog c2
    WHERE c2.pid = c.pid
)
ORDER BY p.pname;
