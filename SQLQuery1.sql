
drop table if exists emp;
create table emp(e_id int not null,e_name nvarchar(20),dept nvarchar(20),salary int)
insert into emp values(1,'ram','hr',10000)
insert into emp values(2,'amrit','mrkt',20000)
insert into emp values(3,'ravi','hr',30000)
insert into emp values(4,'nithin','markt',40000)
insert into emp values(5,'varun','it',50000)
select * from emp

--display max salary from emp
select max(salary) as maximum_salary from emp;
-- display the emp name who is getting highest salary
select e_name from emp where salary = (select max(salary) from emp);
-- display second highest salary from emp
select max(salary) from emp where salary <> (select max(salary) from emp);
--display the emp name who is getting second highest salary
select e_name from emp where salary = (select max(salary) from emp where salary <> (select max(salary) from emp));
-- display all dept name along with no. of employee working in that dept
select dept,count(dept) no_of_employee from emp group by dept;
-- display all dept name where no of employee are less than 2
select dept,count(dept) no_of_employees from emp group by dept having count(dept) < 2;
-- find name of employee who is working in dept which having no.of employees < 2
select e_name from emp where dept  in (select dept no_of_employees from emp group by dept having count(dept) < 2);
-- display the highest dept wise  and name of the employee who is taking the highest salary
select e_name from emp where salary in (select max(salary) from emp group by dept)
--find the details of employee whose address is delhi,pune or jarkhand

drop table if exists emp1;
create table emp1(e_id int,e_name varchar(20),address nvarchar(20))
insert into emp1 values(1,'ram','chandigarh')
insert into emp1 values(2,'amrit','delhi')
insert into emp1 values(3,'ravi','pune')
insert into emp1 values(4,'nithin','banglore')
insert into emp1 values(5,'varun','chandigarh')
insert into emp1 values(6,'ankit','mumbai')

select * from emp1;


drop table if exists project1;
create table project1(e_id int,p_id varchar(20),p_name nvarchar(20),location nvarchar(20))
insert into project1 values(1,'p1','IOT','banglore')
insert into project1 values(2,'p2','bigdata','delhi')
insert into project1 values(3,'p3','retail','mumbai')
insert into project1 values(4,'p4','android','hyd')

select * from project1

--find the details of employee whose address in delhi ,pune or chandigarh

select * from emp1 where address in ('delhi','pune','chandigarh')

--not in delhi ,pune or chandigarh

select * from emp1 where address not in ('delhi','pune','chandigarh')

--join 
select e_name
from emp1,project1 where emp1.e_id = project1.e_id and emp1.address = project1.location

---find the name of the employee who are working on project
select * from project1;
select * from emp1;
--correlated query
select e_name from emp1 where e_id in ( select e_id from project1);
--find name of employee who is working in more than project
/*select e_name from
(select emp1.e_name,count(project1.p_id) as count_p_id
from emp1,project1 
where emp1.e_id = project1.e_id 
group by emp1.e_name)  where count_p_id > 1)*/
-- find the details of employee whois working atleat 1 project
select * from emp1 where e_id in (select distinct(e_id) from project1 where emp1.e_id = project1.e_id)
---- find the details of employee whois not working atleat 1 project
select * from emp1 where e_id not in (select e_id from project1 where emp1.e_id = project1.e_id)
-- find the nth highest salary from emp table

drop table if exists emp2;
create table emp2(id int,salary int)
insert into emp2 values(1,10000)
insert into emp2 values(1,20000)
insert into emp2 values(1,20000)
insert into emp2 values(1,30000)
insert into emp2 values(1,40000)
insert into emp2 values(1,50000)

select * from emp2

select id,salary from emp2 e1
where 4-1 = (select count(distinct(salary)) from emp2 e2 where e2.salary > e1.salary)


select * from project1;
select * from emp1;
-- create view
drop view if exists view_emp_project;
create view view_emp_projet as
select emp1.e_id,emp1.e_name,emp1.address,project1.location,project1.p_id from emp1,project1 where emp1.e_id=project1.e_id

select * from view_emp_projet