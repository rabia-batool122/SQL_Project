/* 
 Question: What skills are required for the top paying data scientist jobs?
 - Use the top 10 highest-paying data scientist jobs from the first query.
 - Add the specific skills required for these jobs.
 - Why? It provides a detailed look at which highest-paying jobs demand certain skills, 
 helping job seekers understand which skills to develop that align with top salaries.
 */
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
    /*
     The analysis of the skills from the top 10 data scientist job postings in 2023 shows the following insights:
     
     The most frequently mentioned skill is Python, appearing in 5 job postings.
     
     SQL follows closely with 4 mentions.
     
     AWS cloud skills appear in 3 postings.
     
     Java and GCP (Google Cloud Platform) are each required in 2 postings.
     
     Several other skills such as Pandas, NumPy, Azure, TensorFlow, Keras, PyTorch, scikit-learn, Datarobot, C, Cassandra, Spark, Hadoop, and Tableau appear once in the postings.
     
     This distribution highlights a strong emphasis on Python, SQL, and cloud platforms (AWS, GCP) in data science job requirements in 2023, along with diverse additional skills related to machine learning frameworks and big data tools. 
     
     [
     {
     "job_id": 40145,
     "job_title": "Staff Data Scientist/Quant Researcher",
     "salary_year_avg": "550000.0",
     "job_posted_date": "2023-08-16 16:05:16",
     "company_name": "Selby Jennings",
     "skills": "sql"
     },
     {
     "job_id": 40145,
     "job_title": "Staff Data Scientist/Quant Researcher",
     "salary_year_avg": "550000.0",
     "job_posted_date": "2023-08-16 16:05:16",
     "company_name": "Selby Jennings",
     "skills": "python"
     },
     {
     "job_id": 1714768,
     "job_title": "Staff Data Scientist - Business Analytics",
     "salary_year_avg": "525000.0",
     "job_posted_date": "2023-09-01 19:24:02",
     "company_name": "Selby Jennings",
     "skills": "sql"
     },
     {
     "job_id": 1131472,
     "job_title": "Data Scientist",
     "salary_year_avg": "375000.0",
     "job_posted_date": "2023-07-31 14:05:21",
     "company_name": "Algo Capital Group",
     "skills": "sql"
     },
     {
     "job_id": 1131472,
     "job_title": "Data Scientist",
     "salary_year_avg": "375000.0",
     "job_posted_date": "2023-07-31 14:05:21",
     "company_name": "Algo Capital Group",
     "skills": "python"
     },
     {
     "job_id": 1131472,
     "job_title": "Data Scientist",
     "salary_year_avg": "375000.0",
     "job_posted_date": "2023-07-31 14:05:21",
     "company_name": "Algo Capital Group",
     "skills": "java"
     },
     {
     "job_id": 1131472,
     "job_title": "Data Scientist",
     "salary_year_avg": "375000.0",
     "job_posted_date": "2023-07-31 14:05:21",
     "company_name": "Algo Capital Group",
     "skills": "cassandra"
     },
     {
     "job_id": 1131472,
     "job_title": "Data Scientist",
     "salary_year_avg": "375000.0",
     "job_posted_date": "2023-07-31 14:05:21",
     "company_name": "Algo Capital Group",
     "skills": "spark"
     },
     {
     "job_id": 1131472,
     "job_title": "Data Scientist",
     "salary_year_avg": "375000.0",
     "job_posted_date": "2023-07-31 14:05:21",
     "company_name": "Algo Capital Group",
     "skills": "hadoop"
     },
     {
     "job_id": 1131472,
     "job_title": "Data Scientist",
     "salary_year_avg": "375000.0",
     "job_posted_date": "2023-07-31 14:05:21",
     "company_name": "Algo Capital Group",
     "skills": "tableau"
     },
     {
     "job_id": 126218,
     "job_title": "Director Level - Product Management - Data Science",
     "salary_year_avg": "320000.0",
     "job_posted_date": "2023-03-26 23:46:39",
     "company_name": "Teramind",
     "skills": "azure"
     },
     {
     "job_id": 126218,
     "job_title": "Director Level - Product Management - Data Science",
     "salary_year_avg": "320000.0",
     "job_posted_date": "2023-03-26 23:46:39",
     "company_name": "Teramind",
     "skills": "aws"
     },
     {
     "job_id": 126218,
     "job_title": "Director Level - Product Management - Data Science",
     "salary_year_avg": "320000.0",
     "job_posted_date": "2023-03-26 23:46:39",
     "company_name": "Teramind",
     "skills": "tensorflow"
     },
     {
     "job_id": 126218,
     "job_title": "Director Level - Product Management - Data Science",
     "salary_year_avg": "320000.0",
     "job_posted_date": "2023-03-26 23:46:39",
     "company_name": "Teramind",
     "skills": "keras"
     },
     {
     "job_id": 126218,
     "job_title": "Director Level - Product Management - Data Science",
     "salary_year_avg": "320000.0",
     "job_posted_date": "2023-03-26 23:46:39",
     "company_name": "Teramind",
     "skills": "pytorch"
     },
     {
     "job_id": 126218,
     "job_title": "Director Level - Product Management - Data Science",
     "salary_year_avg": "320000.0",
     "job_posted_date": "2023-03-26 23:46:39",
     "company_name": "Teramind",
     "skills": "scikit-learn"
     },
     {
     "job_id": 126218,
     "job_title": "Director Level - Product Management - Data Science",
     "salary_year_avg": "320000.0",
     "job_posted_date": "2023-03-26 23:46:39",
     "company_name": "Teramind",
     "skills": "datarobot"
     },
     {
     "job_id": 226011,
     "job_title": "Distinguished Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-08-06 11:00:43",
     "company_name": "Walmart",
     "skills": "scala"
     },
     {
     "job_id": 226011,
     "job_title": "Distinguished Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-08-06 11:00:43",
     "company_name": "Walmart",
     "skills": "java"
     },
     {
     "job_id": 226011,
     "job_title": "Distinguished Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-08-06 11:00:43",
     "company_name": "Walmart",
     "skills": "spark"
     },
     {
     "job_id": 226011,
     "job_title": "Distinguished Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-08-06 11:00:43",
     "company_name": "Walmart",
     "skills": "tensorflow"
     },
     {
     "job_id": 226011,
     "job_title": "Distinguished Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-08-06 11:00:43",
     "company_name": "Walmart",
     "skills": "pytorch"
     },
     {
     "job_id": 226011,
     "job_title": "Distinguished Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-08-06 11:00:43",
     "company_name": "Walmart",
     "skills": "kubernetes"
     },
     {
     "job_id": 129924,
     "job_title": "Director of Data Science",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-01-21 11:09:36",
     "company_name": "Storm4",
     "skills": "python"
     },
     {
     "job_id": 129924,
     "job_title": "Director of Data Science",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-01-21 11:09:36",
     "company_name": "Storm4",
     "skills": "pandas"
     },
     {
     "job_id": 129924,
     "job_title": "Director of Data Science",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-01-21 11:09:36",
     "company_name": "Storm4",
     "skills": "numpy"
     },
     {
     "job_id": 38905,
     "job_title": "Principal Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-11-24 14:08:44",
     "company_name": "Storm5",
     "skills": "sql"
     },
     {
     "job_id": 38905,
     "job_title": "Principal Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-11-24 14:08:44",
     "company_name": "Storm5",
     "skills": "python"
     },
     {
     "job_id": 38905,
     "job_title": "Principal Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-11-24 14:08:44",
     "company_name": "Storm5",
     "skills": "java"
     },
     {
     "job_id": 38905,
     "job_title": "Principal Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-11-24 14:08:44",
     "company_name": "Storm5",
     "skills": "c"
     },
     {
     "job_id": 38905,
     "job_title": "Principal Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-11-24 14:08:44",
     "company_name": "Storm5",
     "skills": "aws"
     },
     {
     "job_id": 38905,
     "job_title": "Principal Data Scientist",
     "salary_year_avg": "300000.0",
     "job_posted_date": "2023-11-24 14:08:44",
     "company_name": "Storm5",
     "skills": "gcp"
     }
     ]
     */