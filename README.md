
# Introduction
This project is a **SQL-based analysis of Data Science job postings**.  
The goal was to uncover insights into the **highest-paying roles, most in-demand skills, and technologies that provide the best salary-to-demand balance**.  

By writing and running multiple SQL queries on a dataset of job postings, I was able to analyze trends in salaries, skills, and hiring demand across the data science job market.  

SQL queries? Check them out here: [project_sql folder](/sql_project/).

# Background
### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data science jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in-demand for data scientists?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
- **SQL** for querying and analysis  
- **PostgreSQL** as the database  
- **VS Code** for query writing  
- **CSV files** for storing and processing results  

# The Analysis

### 1. Top-Paying Data Science Jobs
From the dataset, leadership and senior data science roles dominate the top salaries.  
Two **Staff Data Scientist** positions surpassed **$500k annually**, while roles like **Head of Data Science** and **Director of Data Science** consistently offered salaries above **$300k**.  

```sql
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Scientist'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

| Job Title | Company | Average Salary (USD) |
|-----------|---------|----------------------|
| Staff Data Scientist/Quant Researcher | Selby Jennings | 550,000 |
| Staff Data Scientist - Business Analytics | Selby Jennings | 525,000 |
| Data Scientist | Algo Capital Group | 375,000 |
| Head of Data Science | Demandbase | 351,500 |
| Director of Data Science & Analytics | Reddit | 313,000 |
| Distinguished Data Scientist | Walmart | 300,000 |

---

### 2. Skills Required for Top-Paying Jobs
High-paying roles required a strong mix of **programming, cloud computing, and machine learning frameworks**.  

```sql
WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Scientist'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
```

Key skills included:  
- **Programming & Data**: SQL, Python, Java, Pandas, NumPy  
- **Cloud**: AWS, GCP, Azure  
- **Big Data & Tools**: Spark, Hadoop, Cassandra, Tableau  
- **Machine Learning & AI**: TensorFlow, PyTorch, Scikit-learn, Keras, DataRobot  

Leadership positions especially favored candidates with **breadth of tool knowledge** across cloud and ML platforms.  

---

### 3. Most In-Demand Skills
The most frequently requested skills in job postings were:  

| Skill | Demand Count |
|-------|--------------|
| Python | 10,390 |
| SQL    | 7,488 |
| R      | 4,674 |
| AWS    | 2,593 |
| Tableau| 2,458 |

```sql
SELECT skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Scientist'
    AND job_work_from_home = True
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
```
👉 **Python and SQL dominate**, being the core requirements for data science roles.  

---

### 4. Skills Associated with Higher Salaries

```sql
SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
```

Some niche and specialized skills were associated with significantly higher salaries:  

- **GDPR** – $217k  
- **Golang** – $208k  
- **Atlassian** – $189k  
- **Selenium** – $180k  
- **OpenCV** – $172k  
- **Neo4j** – $171k  

These tools and frameworks are less common but command premium compensation.  

---

### 5. Most Optimal Skills to Learn

```sql
SELECT skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,
    demand_count DESC
LIMIT 25
```
By balancing both **demand** and **average salary**, the following skills emerged as the most valuable to pursue:  

- **Python** – High demand (763 listings), Avg. Salary ~$144k  
- **SQL** – High demand (7.4k listings), Avg. Salary ~$143k  
- **Spark** – Demand 149, Avg. Salary ~$150k  
- **TensorFlow** – Demand 126, Avg. Salary ~$151k  
- **AWS** – Demand 217, Avg. Salary ~$149k  

These technologies provide both **career stability** and **strong earning potential**.  

---

# What I Learned
- SQL can uncover powerful insights from large datasets efficiently.  
- High-paying jobs emphasize **leadership, cloud platforms, and advanced ML frameworks**.  
- Despite new tools, **Python and SQL remain the backbone** of the data science field.  
- Specialized skills (e.g., GDPR, Golang) can give an edge in niche areas.  

# Conclusions
This project highlighted how SQL can be used to answer real-world career-focused questions such as salary trends, skill demands, and optimal learning paths.  

For aspiring data scientists:  
- **Master Python and SQL first.**  
- Learn cloud and big data tools like AWS, Spark, and Hadoop.  
- Explore ML frameworks (TensorFlow, PyTorch, Scikit-learn).  
- Keep an eye on niche skills with high salaries to differentiate yourself in the job market.  
