SELECT * FROM global_ai_jobs.global_ai_jobs_2026_cleaned;
select count(*) from global_ai_jobs_2026_cleaned;
select distinct AI_Specialization from global_ai_jobs_2026_cleaned;
select AI_Specialization, count(*) as job_count from global_ai_jobs_2026_cleaned group by AI_Specialization order by job_count desc;
select AI_Specialization, avg(Salary_USD) as avg_Salary from global_ai_jobs_2026_cleaned group by AI_Specialization 
 having (avg_Salary)>100000 order by avg_salary desc;
select country, avg(salary_USD) as avg_salary from global_ai_jobs_2026_cleaned
group by country order by avg_salary desc limit 10;
select AI_Specialization,sum(job_openings) as total_openings from global_ai_jobs_2026_cleaned
group by AI_Specialization order by total_openings desc ;
select AI_Specialization,sum(job_openings) as total_openings from global_ai_jobs_2026_cleaned
group by AI_Specialization having (total_openings)>500   order by total_openings desc ;
select Experience_Level, avg(Salary_USD) as average_Salary
from global_ai_jobs_2026_cleaned group by Experience_Level 
order by average_Salary desc ;
select Experience_Level, min(Salary_USD) as min_Salary
from global_ai_jobs_2026_cleaned group by Experience_Level 
order by min_Salary desc ;
select Experience_Level, max(Salary_USD) as max_Salary
from global_ai_jobs_2026_cleaned group by Experience_Level 
order by max_Salary desc ;
select AI_Specialization, sum(Job_Openings) as total_opening, avg(Salary_USD) as avg_salary
from global_ai_jobs_2026_cleaned group by AI_Specialization having sum(Job_Openings)>500 and avg(Salary_USD)>100000 order by avg_salary desc;
create table company_info(
Company_Name varchar(150),
Company_Size varchar(50),
Company_AI_Maturity_1_10 decimal(4,2),
AI_Investment_Company_Millions decimal(12,2));
describe global_ai_jobs_2026_cleaned;
insert into company_info(
Company_Name,
Company_Size,
COmpany_AI_Maturity_1_10,
AI_Investment_Company_Millions)
select distinct
Company_Name,
Company_Size,
Company_AI_MAturity_1_10,
AI_Investment_Company_Millions
from global_ai_jobs_2026_cleaned;
drop table company_info;
create table company_info(
Company_Name varchar(150),
Company_Size varchar(50),
Company_AI_Maturity_1_10 decimal(4,2),
AI_Investment_Company_Millions decimal(12,2));
insert into company_info(
Company_Name,
Company_size,
Company_AI_Maturity_1_10,
AI_Investment_Company_Millions
)
select distinct
Company_Name,
Company_size,
Company_AI_Maturity_1_10,
AI_Investment_Company_Millions
 from global_ai_jobs_2026_cleaned;
 describe global_ai_jobs_2026_cleaned;
 insert into company_info(
 Company_Name,
Company_size,
Company_AI_Maturity_1_10,
AI_Investment_Company_Millions
)
select distinct
Company,
Company_size,
Company_AI_Maturity_1_10,
AI_Investment_Company_Millions
 from global_ai_jobs_2026_cleaned;
 select * from company_info limit 10;


describe global_ai_jobs_2026_cleaned;
describe company_info;
select * from global_ai_jobs_2026_cleaned limit 5;
SELECT
    
    j.Company,
    
    c.Company_Size,
    c.Company_AI_Maturity_1_10
FROM global_ai_jobs_2026_cleaned as j
JOIN company_info as c
    ON j.Company = c.Company_Name
LIMIT 20;

select
j.Company,
c.Company_size,
avg(j.Salary_USD) as avg_Salary
from global_ai_jobs_2026_cleaned as j
join company_info as c 
on j.Company=c.Company_Name
group by 
j.Company,
c.Company_Size
order by avg_salary desc limit 10;

select
j.Job_Title,
j.Company,
j.Salary_USD,
c.Company_Size,
c.Company_AI_Maturity_1_10
from global_ai_jobs_2026_cleaned as j
join company_info as c
on j.Company=c.Company_Name limit 20;
describe global_ai_jobs_2026_cleaned;
describe company_info;
SELECT 
    Company, 
    Company_Size, 
    AVG(Salary_USD) AS avg_Salary  
FROM global_ai_jobs_2026_cleaned 
GROUP BY Company, Company_Size 
HAVING AVG(Salary_USD) > 100000 
ORDER BY avg_Salary DESC 
LIMIT 0, 1000;
select avg(Salary_USD) as overall_avg_Salary
from global_ai_jobs_2026_cleaned;
SELECT
    Job_Title,
    Company,
    Salary_USD,
    AI_Specialization
FROM global_ai_jobs_2026_cleaned
WHERE Salary_USD > (
    SELECT AVG(Salary_USD)
    FROM global_ai_jobs_2026_cleaned
)
ORDER BY Salary_USD DESC;
 select
 Job_Title,
 Company,
 AI_Specialization,
 Country,
 Salary_USD
 from global_ai_jobs_2026_cleaned
 where Salary_USD>(
 select avg(Salary_USD)
 from global_ai_jobs_2026_cleaned)
 order by Salary_USD desc limit 20;
 SELECT
    AI_Specialization,
    AVG(Salary_USD) AS Avg_Salary
FROM global_ai_jobs_2026_cleaned
GROUP BY AI_Specialization
HAVING AVG(Salary_USD) > (
    SELECT AVG(Salary_USD)
    FROM global_ai_jobs_2026_cleaned
)
ORDER BY Avg_Salary DESC;

 SELECT
    Company,
    AVG(Salary_USD) AS Avg_Salary
FROM global_ai_jobs_2026_cleaned
GROUP BY Company
HAVING AVG(Salary_USD) > (
    SELECT AVG(Salary_USD)
    FROM global_ai_jobs_2026_cleaned
)
ORDER BY Avg_Salary DESC limit 20;

WITH specialization_analysis AS (
    SELECT
        AI_Specialization,
        COUNT(*) AS Job_Count,
        SUM(Job_Openings) AS Total_Openings,
        AVG(Salary_USD) AS Avg_Salary
    FROM global_ai_jobs_2026_cleaned
    GROUP BY AI_Specialization
)
SELECT
    AI_Specialization,
    Job_Count,
    Total_Openings,
    ROUND(Avg_Salary, 2) AS Avg_Salary
FROM specialization_analysis
WHERE Avg_Salary > 100000
  AND Total_Openings > 500
ORDER BY Avg_Salary DESC;

SELECT
    AI_Specialization,
    ROUND(AVG(Salary_USD), 2) AS Avg_Salary,
    RANK() OVER (
        ORDER BY AVG(Salary_USD) DESC
    ) AS Salary_Rank
FROM global_ai_jobs_2026_cleaned
GROUP BY AI_Specialization
ORDER BY Salary_Rank;
 
 SELECT
    AI_Specialization,
    ROUND(AVG(Salary_USD), 2) AS Avg_Salary,
    Row_number() OVER (
        ORDER BY AVG(Salary_USD) DESC
    ) AS Salary_POsition
FROM global_ai_jobs_2026_cleaned
GROUP BY AI_Specialization
ORDER BY Salary_Position;

 SELECT
    Continent,
    AI_Specialization,
    ROUND(AVG(Salary_USD), 2) AS Avg_Salary,
    Rank() OVER (
    Partition by Continent
        ORDER BY AVG(Salary_USD) DESC
    ) AS Salary_Rank
FROM global_ai_jobs_2026_cleaned
GROUP BY 
Continent,
AI_Specialization
ORDER BY
Continent,
Salary_Rank;

WITH specialization_salary AS (
    SELECT
        Continent,
        AI_Specialization,
        AVG(Salary_USD) AS Avg_Salary
    FROM global_ai_jobs_2026_cleaned
    GROUP BY
        Continent,
        AI_Specialization
)
SELECT
    Continent,
    AI_Specialization,
    ROUND(Avg_Salary, 2) AS Avg_Salary,
    RANK() OVER (
        PARTITION BY Continent
        ORDER BY Avg_Salary DESC
    ) AS Salary_Rank
FROM specialization_salary
ORDER BY
    Continent,
    Salary_Rank;
    WITH specialization_salary AS (
    SELECT
        Continent,
        AI_Specialization,
        AVG(Salary_USD) AS Avg_Salary
    FROM global_ai_jobs_2026_cleaned
    GROUP BY
        Continent,
        AI_Specialization
),
ranked_specializations AS (
    SELECT
        Continent,
        AI_Specialization,
        Avg_Salary,
        RANK() OVER (
            PARTITION BY Continent
            ORDER BY Avg_Salary DESC
        ) AS Salary_Rank
    FROM specialization_salary
)
SELECT
    Continent,
    AI_Specialization,
    ROUND(Avg_Salary, 2) AS Avg_Salary
FROM ranked_specializations
WHERE Salary_Rank = 1
ORDER BY Avg_Salary DESC;

SELECT
    AI_Specialization,
    SUM(Competition_Level_Applicants) AS Total_Applicants,
    SUM(Job_Openings) AS Total_Openings,
    ROUND(
        SUM(Competition_Level_Applicants) /
        SUM(Job_Openings), 2
    ) AS Applicants_Per_Opening
FROM global_ai_jobs_2026_cleaned
GROUP BY AI_Specialization
ORDER BY Applicants_Per_Opening DESC;


SELECT
    Country,
    SUM(Competition_Level_Applicants) AS Total_Applicants,
    SUM(Job_Openings) AS Total_Openings,
    ROUND(
        SUM(Competition_Level_Applicants) /
        SUM(Job_Openings), 2
    ) AS Applicants_Per_Opening
FROM global_ai_jobs_2026_cleaned
GROUP BY Country
HAVING SUM(Job_Openings) > 0
ORDER BY Applicants_Per_Opening DESC
LIMIT 15;

SELECT
    AI_Specialization,
    ROUND(AVG(Salary_USD), 2) AS Avg_Salary,
    SUM(Job_Openings) AS Total_Openings,
    SUM(Competition_Level_Applicants) AS Total_Applicants,
    ROUND(
        SUM(Competition_Level_Applicants) /
        SUM(Job_Openings), 2
    ) AS Applicants_Per_Opening
FROM global_ai_jobs_2026_cleaned
GROUP BY AI_Specialization
HAVING SUM(Job_Openings) > 0
ORDER BY Avg_Salary DESC;

SELECT
    AI_Specialization,

    ROUND(AVG(Salary_USD), 2) AS Avg_Salary,

    SUM(Job_Openings) AS Total_Openings,

    ROUND(AVG(`Job_Growth_Projection_%`), 2) AS Avg_Growth,

    ROUND(AVG(`Remote_Work_%`), 2) AS Avg_Remote_Work,

    SUM(Competition_Level_Applicants) AS Total_Applicants,

    ROUND(
        SUM(Competition_Level_Applicants) /
        NULLIF(SUM(Job_Openings), 0),
        2
    ) AS Applicants_Per_Opening,

    ROUND(AVG(`Automation_Risk_%`), 2) AS Avg_Automation_Risk

FROM global_ai_jobs_2026_cleaned

GROUP BY AI_Specialization

HAVING SUM(Job_Openings) > 0

ORDER BY Avg_Growth DESC;

WITH career_metrics AS (

    SELECT
        AI_Specialization,

        AVG(Salary_USD) AS Avg_Salary,

        SUM(Job_Openings) AS Total_Openings,

        AVG(`Job_Growth_Projection_%`) AS Avg_Growth,

        AVG(`Remote_Work_%`) AS Avg_Remote_Work,

        SUM(Competition_Level_Applicants) /
        NULLIF(SUM(Job_Openings), 0) AS Applicants_Per_Opening,

        AVG(`Automation_Risk_%`) AS Avg_Automation_Risk

    FROM global_ai_jobs_2026_cleaned

    GROUP BY AI_Specialization
)

SELECT *
FROM career_metrics;


WITH career_metrics AS (

    SELECT
        AI_Specialization,
        AVG(Salary_USD) AS Avg_Salary,
        SUM(Job_Openings) AS Total_Openings,
        AVG(`Job_Growth_Projection_%`) AS Avg_Growth,
        AVG(`Remote_Work_%`) AS Avg_Remote_Work,
        SUM(Competition_Level_Applicants) /
            NULLIF(SUM(Job_Openings), 0) AS Applicants_Per_Opening,
        AVG(`Automation_Risk_%`) AS Avg_Automation_Risk
    FROM global_ai_jobs_2026_cleaned
    GROUP BY AI_Specialization
),

normalized_metrics AS (

    SELECT
        *,
        
        (Avg_Salary - MIN(Avg_Salary) OVER()) /
        NULLIF(
            MAX(Avg_Salary) OVER() - MIN(Avg_Salary) OVER(),
            0
        ) AS Salary_Score,

        (Total_Openings - MIN(Total_Openings) OVER()) /
        NULLIF(
            MAX(Total_Openings) OVER() - MIN(Total_Openings) OVER(),
            0
        ) AS Demand_Score,

        (Avg_Growth - MIN(Avg_Growth) OVER()) /
        NULLIF(
            MAX(Avg_Growth) OVER() - MIN(Avg_Growth) OVER(),
            0
        ) AS Growth_Score,

        (Avg_Remote_Work - MIN(Avg_Remote_Work) OVER()) /
        NULLIF(
            MAX(Avg_Remote_Work) OVER() - MIN(Avg_Remote_Work) OVER(),
            0
        ) AS Remote_Score,

        (Applicants_Per_Opening - MIN(Applicants_Per_Opening) OVER()) /
        NULLIF(
            MAX(Applicants_Per_Opening) OVER() -
            MIN(Applicants_Per_Opening) OVER(),
            0
        ) AS Competition_Score,

        (Avg_Automation_Risk - MIN(Avg_Automation_Risk) OVER()) /
        NULLIF(
            MAX(Avg_Automation_Risk) OVER() -
            MIN(Avg_Automation_Risk) OVER(),
            0
        ) AS Automation_Score

    FROM career_metrics
)

SELECT
    AI_Specialization,
    ROUND(Avg_Salary, 2) AS Avg_Salary,
    Total_Openings,
    ROUND(Avg_Growth, 2) AS Avg_Growth,
    ROUND(Avg_Remote_Work, 2) AS Avg_Remote_Work,
    ROUND(Applicants_Per_Opening, 2) AS Applicants_Per_Opening,
    ROUND(Avg_Automation_Risk, 2) AS Avg_Automation_Risk,

    ROUND(
        (
            Salary_Score * 25
            + Growth_Score * 25
            + Demand_Score * 20
            + Remote_Score * 10
            - Competition_Score * 10
            - Automation_Score * 10
        ),
        2
    ) AS Career_Opportunity_Score

FROM normalized_metrics

ORDER BY Career_Opportunity_Score DESC;



