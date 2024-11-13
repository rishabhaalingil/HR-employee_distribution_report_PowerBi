create database projects;

use projects;
select * from hr;

-- ------------------------------------------------Altering the column names----------------------------------------------------
alter table hr 
change column ï»¿id emp_id varchar(20) NULL;

DESCRIBE hr;

-- ------------------------------------------------Altering the birthdate column formats-------------------------------------------------
select birthdate from hr;

update hr
set birthdate  =CASE
	WHEN birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    else null
end;
select birthdate from hr;


ALTER TABLE hr
modify column birthdate DATE;
-- -----------------------------------------------Altering the hiredate column formats------------------------------------------


update hr
set hire_date =CASE
	WHEN hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
    else null
end;

ALTER TABLE hr
modify column hire_date DATE;

select hire_date from hr;

-- ----------------------------------Altering the termination date column formats-----------------------------------------------

update hr
set termdate=if(termdate is not null and termdate!='',date(str_to_date(termdate,"%Y-%m-%d %H:%i:%s UTC")),"0000-00-00")
where true;


SELECT termdate from hr;

set sql_mode = "ALLOW_INVALID_DATES";

ALTER TABLE hr
modify column termdate DATE;

-- -------------------------------------------------Adding New columns---------------------------------------------------------

ALTER TABLE hr DROP COLUMN age;
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
set age=timestampdiff(Year,birthdate,CURDATE());

SELECT birthdate,age from hr;

select 
	min(age) as youngest,
    max(Age) as oldest 
from hr;

-- -------------------------------------------For birthdates greater than current date---------------------------------------
update hr
set birthdate = DATE_SUB(birthdate,interval 100 YEAR)
where birthdate > curdate();

-- ----------------------------------------------------ANALYSIS--------------------------------------------------------------
-- ---------------------------------------------------Questions--------------------------------------------------------------
-- 1.What is the gender breakdown of the employees in the company?
SELECT gender,COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate="0000-00-00"
GROUP BY gender;
SET sql_mode = "ALLOW_INVALID_DATES";

-- 2.What is the race and ethinicity breakdown of employees in the company?
SELECT race,COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate="0000-00-00"
GROUP BY race;
SET sql_mode = "ALLOW_INVALID_DATES";

-- 3.What is the age distribution of employees in the company?
SELECT 
	max(age) as oldest,
    min(age) as youngest
FROM hr
WHERE age>=18 AND termdate="0000-00-00";
SET sql_mode = "ALLOW_INVALID_DATES";

SELECT 
	CASE 
		WHEN age>=18 AND age<=24 THEN "18-24"
        WHEN age>=25 AND age<=34 THEN "25-34"
        WHEN age>=35 AND age<=44 THEN "35-44"
        WHEN age>=45 AND age<=54 THEN "45-54"
        WHEN age>=55 AND age<=64 THEN "55-64"
        ELSE "65+"
        END AS age_group,
        COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate="0000-00-00"
GROUP BY age_group
order by age_group;

SELECT 
	CASE 
		WHEN age>=18 AND age<=24 THEN "18-24"
        WHEN age>=25 AND age<=34 THEN "25-34"
        WHEN age>=35 AND age<=44 THEN "35-44"
        WHEN age>=45 AND age<=54 THEN "45-54"
        WHEN age>=55 AND age<=64 THEN "55-64"
        ELSE "65+"
        END AS age_group,gender,
        COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate="0000-00-00"
GROUP BY age_group,gender
order by age_group,gender;

-- 4. How many employees work at the headquarters versus remote locations?
SELECT location,count(*)
FROM hr 
WHERE age>=18 AND termdate="0000-00-00"
GROUP BY location;

-- 5.What is the average length of employment for employees who have been terminated?
SELECT 
	round(avg(DATEDIFF(termdate,hire_date))/365,0) as avg_length_employment
FROM hr
WHERE termdate<>"0000-00-00" AND termdate<=curdate() AND age>="18";

-- 6.How does the gender distribution vary across departments and job titles?
SELECT gender,department,COUNT(*) as count
FROM hr
WHERE age>=18 AND termdate="0000-00-00"
GROUP BY gender,department
ORDER BY department;

-- 7.What is the distribution of job titles across the company?
SELECT jobtitle,count(*) as count
FROM hr
WHERE age>=18 AND termdate="0000-00-00"
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8.Which department has the highest turnover?
SELECT department,
	terminated_count,
    total_count,
    terminated_count/total_count as termination_rate
FROM (
	SELECT department,
    COUNT(*) AS total_count,
    SUM(CASE WHEN termdate<>"0000-00-00" AND termdate<=curdate() THEN 1 ELSE 0 END) AS terminated_count
    FROM hr
    WHERE age>=18
    GROUP BY department
    )as subquery 
GROUP BY department
ORDER BY termination_rate DESC;
    
-- 9.What is the distribution of employees across locations by city and state?
SELECT location_state,COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate="0000-00-00"
GROUP BY location_state
ORDER BY count DESC;

-- 10.How has the employee count changed over time based on hire and term dates?
SELECT 
	year,
    hires,
    terminations,
    hires-terminations AS net_change,
    round((hires-terminations)/hires*100,2) AS net_change_percentage
FROM(
	SELECT 
		YEAR(hire_date) AS year,
		COUNT(*) as hires,
        SUM(CASE WHEN termdate<>"0000-00-00" and termdate<=curdate() THEN 1 ELSE 0 END) AS terminations
        FROM hr
        WHERE age>=18
        GROUP BY YEAR(hire_date)
)AS subquery
ORDER BY year ASC;

-- 10.What is the tenure distribution of each department?
SELECT department,round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr
WHERE termdate<=curdate() AND termdate<>'0000-00-00' AND age>=18
GROUP BY department;
	
    