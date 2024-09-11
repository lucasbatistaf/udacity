-- 6 [Advanced] SQL Window Functions
-- 6.3 Quiz: Window Functions 1
SELECT
 standard_amt_usd
 , SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM
 orders


-- 6.5 Quiz: Window Functions 2
SELECT
 standard_amt_usd
 , SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM
 orders


-- 6.8 Quiz: ROW_NUMBER & RANK
SELECT
 id
 , account_id
 , total
 , RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM
 orders


-- 6.14 Quiz: Aliases for Multiple Window Functions
SELECT 
    id
    , account_id
    , DATE_TRUNC('year',occurred_at) AS year
    , DENSE_RANK() OVER account_year_window AS dense_rank
    , total_amt_usd
    , SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd
    , COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd
    , AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd
    , MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd
    , MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))


-- 6.17 Quiz: Comparing a Row to Previous Row
WITH account_sum AS(
SELECT occurred_at,
       SUM(total_amt_usd) AS total_usd
  FROM orders 
 GROUP BY 1
 )

SELECT occurred_at,
       total_usd,
       LEAD(total_usd) OVER (ORDER BY occurred_at) AS lead,
       LEAD(total_usd) OVER (ORDER BY occurred_at) - total_usd AS lead_difference
FROM
 account_sum
ORDER BY
 4
 

-- 6.21 Quiz: Percentiles
-- 1
SELECT
 account_id
 , occurred_at
 , standard_qty
 , NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile
FROM
 orders
ORDER BY account_id DESC

-- 2
SELECT
 account_id
 , occurred_at
 , gloss_qty
 , NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) AS gloss_half
FROM
 orders
ORDER BY account_id DESC


-- 3
SELECT
 account_id
 , occurred_at
 , total_amt_usd
 , NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
FROM
 orders
ORDER BY account_id DESC