create database car_details;
show databases;
use car_details;
create table car(reg_no varchar(10), model varchar(20), year int(4),primary key(reg_no));
create table accident(rep_no int, accident_date date,loc varchar(20),primary key(rep_no));
create table person (dr_id varchar(10), name varchar(20),  address varchar(30), primary key(dr_id));
create table owns(dr_id varchar(20),reg_no varchar(10), 
primary key(dr_id,reg_no),foreign key(dr_id) references person(dr_id), foreign key(reg_no) references car(reg_no));
create table participated(dr_id varchar(10), reg_no varchar(10), rep_no int, damage_amt int, 
primary key(dr_id, reg_no, rep_no), foreign key(dr_id) references person(dr_id),
foreign key(reg_no) references car(reg_no),foreign key(rep_no) references accident(rep_no));
insert into accident values (11, '2003-01-01','Mysore Road');
insert into accident values (12,'2004-02-02','South end Circle');
insert into accident values (13,'2003-01-21','Bull temple Road');
insert into accident values (14,'2008-02-17','Mysore Road');
insert into accident values (15,'2004-03-05','Kanakpura Road');
select *from accident;
insert into car values ('KA052250','Indica',1990);
insert into car values ('KA092958','Toyota',1999);
insert into car values ('KA519987','Honda',2009);
insert into car values ('KA056648','Audi',1985);
insert into car values ('KA414988','Honda',2011);
select *from car;
insert into person values 
('A01','John','Bengaluru'),
('A02','Smith','Mysore'),
('A03','David','Hubli'),
('A04','Ravi','Tumkur'),
('A05','Arun','Mandya');
select *from person;
insert into owns values
('A01','KA052250'),
('A02','KA092958'),
('A03','KA519987'),
('A04','KA056648'),
('A05','KA414988');
select *from owns;
insert into participated values
('A01','KA052250',11,10000),
('A02','KA092958',12,50000),
('A03','KA519987',13,25000),
('A04','KA056648',14,3000),
('A05','KA414988',15,5000);
select *from participated;
update participated set damage_amt=25000 where reg_no='KA092958'and rep_no=12;
insert into accident values(16,'2015-03-08','Domlur');
select * from car order by year asc;                                                                                      
select count(rep_no) CNT from car c,participated p where c.reg_no=p.reg_no and model='Honda';
select count(distinct dr_id) CNT from participated a, accident b where a.rep_no=b.rep_no and b.accident_date like '%08';
select *from participated order by damage_amt desc;
select avg(damage_amt) from participated;  
SET SQL_SAFE_UPDATES = 0;
set @a=(SELECT AVG(damage_amt) FROM participated);                                                
DELETE FROM participated WHERE damage_amt<(@a);                                     
select *from participated;                                        
select name from person a,participated b where a.dr_id=b.dr_id and damage_amt>(select avg(damage_amt) from participated);
select max(damage_amt)from participated;






