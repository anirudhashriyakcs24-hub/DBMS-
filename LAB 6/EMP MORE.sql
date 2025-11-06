use emp;
create table dept (
 deptno decimal(2 , 0 ) primary key,
 dname varchar(14) default null,
 loc varchar(13) default null
);
create table emp (
 empno decimal(4 , 0 ) primary key,
 ename varchar(10) default null,
 mgr_no decimal(4 , 0 ) default null,
 hiredate date default null,
 sal decimal(7 , 2 ) default null,
 deptno decimal(2 , 0 ) references dept (deptno)
 on delete cascade on update cascade
);
create table incentives (
 empno decimal(4 , 0 ) references emp (empno)
 on delete cascade on update cascade,
 incentive_date date,
 incentive_amount decimal(10 , 2 ),
 primary key (empno , incentive_date)
);
create table project (
 pno int primary key,
 pname varchar(30) not null,
ploc varchar(30)
);
create table assigned_to (
 empno decimal(4 , 0 ) references emp (empno)
 on delete cascade on update cascade,
 pno int references project (pno)
 on delete cascade on update cascade,
 job_role varchar(30),
 primary key (empno , pno));
insert into dept values (10, 'accounting', 'mumbai');
insert into dept values (20, 'research', 'bengaluru');
insert into dept values (30, 'sales', 'delhi');
insert into dept values (40, 'operations', 'chennai');
select * from dept;
insert into emp values (7369, 'adarsh', 7902, '2012-12-17', '80000.00', '20');
insert into emp values (7499, 'shruthi', 7698, '2013-02-20', '16000.00', '30');
insert into emp values (7521, 'anvitha', 7698, '2015-02-22', '12500.00', '30');
insert into emp values (7566, 'tanvir', 7839, '2008-04-02', '29750.00', '20');
insert into emp values (7654, 'ramesh', 7698, '2014-09-28', '12500.00', '30');
insert into emp values (7698, 'kumar', 7839, '2015-05-01', '28500.00', '30');
insert into emp values (7782, 'clark', 7839, '2017-06-09', '24500.00', '10');
insert into emp values (7788, 'scott', 7566, '2010-12-09', '30000.00', '20');
insert into emp values (7839, 'king', null, '2009-11-17', '90000', '10');
insert into incentives values(7499, '2019-02-01', 5000.00);
insert into incentives values(7521, '2019-03-01', 2500.00);
insert into incentives values(7566, '2022-02-01', 5070.00);
insert into incentives values(7654, '2020-02-01', 2000.00);                         
insert into incentives values(7654, '2022-04-01', 879.00);
insert into incentives values(7521, '2019-02-01', 8000.00);
insert into incentives values(7698, '2019-03-01', 500.00);
insert into incentives values(7698, '2020-03-01', 9000.00);
insert into incentives values(7698, '2022-04-01', 4500.00);
select * from incentives;
insert into project values(101, 'ai project', 'bengaluru');
insert into project values(102, 'iot', 'hyderabad');
insert into project values(103, 'blockchain', 'bengaluru');
insert into project values(104, 'data science', 'mysuru');
insert into project values(105, 'autonomous systems', 'pune');
select * from project;
insert into assigned_to values(7499, 101, 'software engineer');
insert into assigned_to values(7521, 101, 'software architect');
insert into assigned_to values(7566, 101, 'project manager');
insert into assigned_to values(7654, 102, 'sales');
insert into assigned_to values(7521, 102, 'software engineer');
insert into assigned_to values(7499, 102, 'software engineer');
insert into assigned_to values(7654, 103, 'cyber security');
insert into assigned_to values(7698, 104, 'software engineer');     
insert into assigned_to values(7839, 104, 'general manager');
select * from assigned_to;
SELECT e.ename AS Manager_Name
FROM emp e
JOIN emp m ON e.empno = m.mgr_no
GROUP BY e.empno, e.ename
HAVING COUNT(m.empno) = (
    SELECT MAX(emp_count)
    FROM (
        SELECT COUNT(*) AS emp_count
        FROM emp
        WHERE mgr_no IS NOT NULL
        GROUP BY mgr_no
    ) AS subq
);
SELECT e.ename AS Manager_Name, e.sal AS Manager_Salary
FROM emp e
JOIN emp m ON e.empno = m.mgr_no
GROUP BY e.empno, e.ename, e.sal
HAVING e.sal > AVG(m.sal);
SELECT DISTINCT e.ename AS Second_Level_Manager, d.dname AS Department
FROM emp e
JOIN emp m ON e.mgr_no = m.empno
JOIN dept d ON e.deptno = d.deptno
WHERE m.mgr_no IS NULL;
SELECT e.empno, e.ename, i.incentive_amount
FROM emp e
JOIN incentives i ON e.empno = i.empno
WHERE MONTH(i.incentive_date) = 2
  AND YEAR(i.incentive_date) = 2019
ORDER BY i.incentive_amount DESC
LIMIT 1 OFFSET 1;
SELECT e.empno, e.ename, e.deptno
FROM emp e
JOIN emp m ON e.mgr_no = m.empno where e.deptno = m.deptno;