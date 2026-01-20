/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM 'C:\Users\14087\Downloads\Harish\CS\VSCode Projects\sql project data jobs\csv_files\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\Users\14087\Downloads\Harish\CS\VSCode Projects\sql project data jobs\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\Users\14087\Downloads\Harish\CS\VSCode Projects\sql project data jobs\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\Users\14087\Downloads\Harish\CS\VSCode Projects\sql project data jobs\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- NOTE: This has been updated from the video to fix issues with encoding

COPY company_dim
FROM 'C:\Users\14087\Downloads\Harish\CS\VSCode Projects\sql project data jobs\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\14087\Downloads\Harish\CS\VSCode Projects\sql project data jobs\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Users\14087\Downloads\Harish\CS\VSCode Projects\sql project data jobs\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Users\14087\Downloads\Harish\CS\VSCode Projects\sql project data jobs\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


select * from job_postings_fact
limit 100;

select job_title_short, job_location, job_posted_date::date
from job_postings_fact

select '2023-02-19'::date, '123'::integer, 'true'::boolean, '3.14'::real;



select job_title_short, job_location, job_posted_date at time zone 'EST' at time zone 'PST'
from job_postings_fact
limit 5;

select job_title_short, job_location, job_posted_date at time zone 'EST' at time zone 'PST', extract(month from job_posted_date)
from job_postings_fact
limit 5;

select count(job_id) as job_posted_counting, extract(month from job_posted_date) as month
from job_postings_fact
where job_title_short = 'Data Analyst'
group by month
order by job_posted_counting




SELECT
  job_schedule_type,
  AVG(salary_year_avg) AS avg_year_salary,
  AVG(salary_hour_avg) AS avg_hour_salary,
  EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) BETWEEN 6 AND 12
GROUP BY job_schedule_type, month


create table january_jobs AS
select *
from job_postings_fact
where extract(month from job_posted_date) = 1;

create table february_jobs AS
select *
from job_postings_fact
where extract(month from job_posted_date) = 2;

create table march_jobs AS
select *
from job_postings_fact
where extract(month from job_posted_date) = 3;

select job_posted_date
from march_jobs





select job_location, job_title_short,
    case
     when job_location = 'Anywhere' then 'Remote'
     when job_location = 'New York, NY' then 'Local'
     else 'Onsite'
    end as location_category
from job_postings_fact   






select count(job_id) as number_of_jobs,
    CASE
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'Local'
        else 'Onsite'
    end as location_category
from job_postings_fact
where job_title_short = 'Data Analyst'
group by location_category 



select salary_year_avg, job_title_short,
    CASE 
        WHEN salary_year_avg > 100000 then 'good'
        WHEN salary_year_avg between 80000 and 100000 then 'fine'
        ELSE 'not ideal'
    end as salary_condition
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' and salary_year_avg is not null
order by salary_year_avg desc

select *
from (
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 1
    ) as january_jobs


with january_jobs as(
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 1
)

select *
from january_jobs




select company_id, name as company_name
from company_dim
where company_id in (
    select company_id
    from job_postings_fact
    where job_no_degree_mention = TRUE
)
order by company_id 




--*
with company_job_count as(
    select company_id, count(*)
    from job_postings_fact
    group by company_id
)
select company_dim.name as company_name
from company_job_count 
left join company_job_count on company_dim



select job_title_short, company_id, job_location
from january_jobs

union 

select job_title_short, company_id, job_location
from february_jobs

union

select job_title_short, company_id, job_location
from march_jobs



select job_title_short, company_id, job_location
from january_jobs

union all

select job_title_short, company_id, job_location
from february_jobs

union all

select job_title_short, company_id, job_location
from march_jobs

select * from job_postings_fact

--

