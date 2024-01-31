SELECT *
FROM data_analyst_jobs;

/*1. How many rows are in the data_analyst_jobs table?*/

SELECT COUNT (*) AS count_rows
FROM data_analyst_jobs;

/*2. Write a query to look at just the first 10 rows. What company is associated with the job posting 
on the 10th row?*/

SELECT *
FROM data_analyst_jobs
LIMIT 10;

/*3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?*/

SELECT *
FROM data_analyst_jobs
WHERE location ILIKE 'TN';

SELECT COUNT(CASE WHEN location ILIKE 'TN' THEN 1 END)AS total_post_TN,
	   COUNT(CASE WHEN location ILIKE 'KY' THEN 1 END)AS total_post_KY
FROM data_analyst_jobs;

/*4. How many postings in Tennessee have a star rating above 4?*/

SELECT *
FROM data_analyst_jobs
WHERE location ILIKE 'TN' AND star_rating > 4;

/*5.How many postings in the dataset have a review count between 500 and 1000?*/

SELECT *
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

/*6.Show the average star rating for companies in each state. The output should show 
the state as `state` and the average rating for the state as `avg_rating`. Which state 
shows the highest average rating?*/


SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT null AND LENGTH(location) = 2
GROUP BY location 
ORDER BY AVG(star_rating) DESC;

/*7.Select unique job titles from the data_analyst_jobs table. How many are there?*/

SELECT COUNT (DISTINCT title)AS total_unique_job_title
FROM data_analyst_jobs;

/*8.How many unique job titles are there for California companies?*/

SELECT COUNT (DISTINCT title)AS CA_total_unique_job_title
FROM data_analyst_jobs
WHERE location ILIKE 'CA';

/*9.Find the name of each company and its average star rating for all companies that 
have more than 5000 reviews across all locations. How many companies are there with more 
that 5000 reviews across all locations?*/

SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT null
GROUP BY company;

SELECT company, 
	ROUND(AVG(star_rating),1) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT null
GROUP BY company
HAVING SUM(review_count) >5000;


/*10.Add the code to order the query in #9 from highest to lowest average star rating.
Which company with more than 5000 reviews across all locations in the dataset has the 
highest star rating? What is that rating?*/

SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT null
GROUP BY star_rating, company
ORDER BY star_rating DESC, company;

SELECT company, 
	ROUND(AVG(star_rating),1) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT null
GROUP BY company
HAVING SUM(review_count) >5000
ORDER BY AVG(star_rating) DESC;

/*11.Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?*/

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

/*12.How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 
What word do these positions have in common?*/

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' 
AND title NOT ILIKE '%Analytics%';

/*BONUS.You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by 
industry (domain) that require SQL and have been posted longer than 3 weeks. 
 - Disregard any postings where the domain is NULL. 
 - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
 - Which three industries are in the top 3 on this list? How many jobs have been listed for more than 
 3 weeks for each of the top 3?*/
 
SELECT *
FROM data_analyst_jobs;

SELECT domain
FROM data_analyst_jobs
WHERE domain IS NOT null
AND skill ILIKE '%SQL%'
GROUP BY domain
HAVING SUM(days_since_posting) > 21
ORDER BY SUM(days_since_posting) DESC;

SELECT domain, COUNT (title) AS jobs_posted_more_than_three_weeks
FROM data_analyst_jobs 
WHERE domain IS NOT null
AND skill ILIKE '%SQL%'
GROUP BY domain
HAVING SUM(days_since_posting) > 21
ORDER BY SUM(days_since_posting) DESC;