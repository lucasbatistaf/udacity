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