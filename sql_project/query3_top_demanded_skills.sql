/*
Question: What are the top 5 most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Focus on all job postings.
*/

select skills, count(skills) as demand_amount
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and job_location = 'Anywhere'
group by skills
order by demand_amount desc
limit 5


/*
The top 5 most demanded skills for data analysts are below. 
SQL and Excel remain as foundational skills in data processing and spreadsheet manipulation.
Programming and Visualization Tools like Python, Tableau, and Power BI show increasing importance of technical skills in data storytelling and decision support.

[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]
*/
