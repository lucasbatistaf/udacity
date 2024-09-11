-- 7 [Advanced] SQL Advanced Join & Performance Tuning
-- 7.3 FULL OUTER JOIN
SELECT *
FROM accounts AS a
FULL JOIN 
sales_reps AS s ON s.id = a.sales_rep_id


-- 7.6 Quiz: JOINs with Comparison Operators
SELECT 
 a.name
 , a.primary_poc
 , s.name
FROM
 accounts AS a
LEFT JOIN
 sales_reps AS s on s.id = a.sales_rep_id
 AND a.primary_poc < s.name

 
 --7.9 Quiz: Self JOINs
SELECT
 w1.id AS w1_id
 , w1.account_id AS w1_account_id
 , w1.occurred_at AS w1_occurred_at
 , w1.channel AS w1_channel
 , w2.id AS w2_id
 , w2.account_id AS w2_account_id
 , w2.occurred_at AS w2_occurred_at
 , w2.channel AS w2_channel
FROM
 web_events AS w1
LEFT JOIN
 web_events AS w2 ON w1.account_id = w2.account_id
 AND w1.occurred_at > w2.occurred_at
 AND w1.occurred_at <= w2.occurred_at + INTERVAL '1 day'
ORDER BY
 w1.account_id
 , w2.occurred_at


 -- 7.12 Quiz: UNION
WITH double_table AS(
 SELECT *
 FROM accounts

 UNION ALL

 SELECT *
 FROM accounts
)

SELECT
 name
 , COUNT(name)
FROM
 double_table AS d
GROUP BY
1