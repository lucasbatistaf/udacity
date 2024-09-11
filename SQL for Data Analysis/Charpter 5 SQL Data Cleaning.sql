-- 5 SQL Data Cleaning
-- 5.3 Quiz: LEFT & RIGHT
-- 1
SELECT 
 RIGHT(website, 3) AS website_type
 , COUNT(*) counter
FROM accounts
GROUP BY 1
ORDER BY 2 DESC

-- 2
SELECT 
    LEFT(UPPER(name), 1) AS first_letter
    , COUNT(*) counter
FROM 
 accounts
GROUP BY 1
ORDER BY 2 DESC


-- 3
WITH t1 AS(
 SELECT
  name
  , CASE
  WHEN LEFT(name, 1) IN ('1','2','3','4','5','6','7','8','9') THEN NULL
  ELSE 'letter'
 END AS begin_with
 FROM
  accounts
 GROUP BY 1
 ORDER BY 2 DESC
)

SELECT
 COUNT(t1.begin_with), COUNT(a.name) AS proportion
FROM
 accounts a
LEFT JOIN
 t1 ON a.name = t1.name

 
-- 4
WITH t1 AS(
 SELECT
  name
  , CASE
  WHEN LEFT(name, 1) IN ('A','E','I','O','U') THEN NULL
  ELSE 'letter'
 END AS begin_with
 FROM
 accounts
 GROUP BY 1
  ORDER BY 2 DESC
)

SELECT
 ((COUNT(t1.begin_with)+0.0) / (COUNT(a.name)+0.0)) *100 AS proportion
FROM
 accounts a
LEFT JOIN
 t1 ON a.name = t1.name
 

-- 5.6 Quizzes POSITION & STRPOS
-- 1
SELECT 
 LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) as first_name
 , RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) as last_name
FROM
 accounts


-- 2
SELECT 
 LEFT(name, STRPOS(name, ' ')-1) AS first_name
 , RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) AS last_name
FROM
 sales_reps


-- 5.9 Quiz: CONCAT
-- 1
WITH t1 AS(
 SELECT
  LOWER(LEFT(primary_poc, STRPOS(primary_poc, ' ') -1)) AS first_name
  , LOWER(RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' '))) AS last_name
  , LOWER(name) AS company_name
  FROM
   accounts
)
SELECT
 t1.first_name || '.' || t1.last_name || '@' || t1.company_name || '.com' as email
 FROM
  t1


-- 2
WITH t1 AS(
 SELECT
  LOWER(LEFT(primary_poc, STRPOS(primary_poc, ' ') -1)) AS first_name
  , LOWER(RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' '))) AS last_name
  , LOWER(REPLACE(name, ' ', '')) AS company_name
  FROM
   accounts
)
SELECT
 t1.first_name || '.' || t1.last_name || '@' || t1.company_name || '.com' as email
 FROM
  t1


-- 3
WITH t1 AS(
 SELECT
  LOWER(LEFT(primary_poc, STRPOS(primary_poc, ' ') -1)) AS first_name
  , LOWER(RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' '))) AS last_name
  , LOWER(REPLACE(name, ' ', '')) AS company_name
  FROM
   accounts
)
SELECT
 CONCAT(first_name, '.', last_name, '@', company_name, '.com') AS email
 , CONCAT(LEFT(first_name, 1)
          , RIGHT(first_name, 1)
          , LEFT(last_name, 1)
          , RIGHT(last_name, 1)
          , LENGTH(first_name)
          , LENGTH(last_name)
          , UPPER(company_name)) AS password
 FROM
  t1


-- 5.12 CAST Quizzes
SELECT
 CONCAT(SUBSTR(date, 7, 4), '-'
        , SUBSTR(date, 1, 2), '-'
        , SUBSTR(date, 4, 2))::date AS dates
FROM
 sf_crime_data
LIMIT
 10

