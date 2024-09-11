-- 4 SQL Subqueries & Temporary Tables
-- 4.3 Video + Quiz: Write Your First Subquery
SELECT 
 channel
 , AVG(count_events) AS avg_event
FROM (SELECT 
       DATE_TRUNC('day',occurred_at) AS day
       , channel
       , COUNT(*) AS count_events
      FROM web_events 
      GROUP BY 1,2)
GROUP BY channel
ORDER BY 2 DESC

-- 4.7 Quiz: More On Subqueries
SELECT
 AVG(standard_qty) AS avg_standard
 , AVG(gloss_qty) AS avg_gloss
 , AVG(poster_qty) AS avg_poster
 , SUM(total_amt_usd) AS total_amt
FROM
 orders
WHERE
DATE_TRUNC('month', occurred_at) = (SELECT DATE_TRUNC('month', MIN(occurred_at)) AS month FROM orders)


-- 4.13 Quiz: WITH
WITH t1 AS (
      SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
      FROM accounts a
      JOIN orders o
      ON o.account_id = a.id
      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 1), 
t2 AS (
      SELECT a.name
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY 1
      HAVING SUM(o.total) > (SELECT total FROM t1))
SELECT COUNT(*)
FROM t2;

