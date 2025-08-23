-- Definition: Average number of orders placed by customers who placed at least one order.

-- Why: Helps understand buying frequency and active-customer behaviour.

-- Task: Compute average orders_count across customers with ≥1 order.

-- How to approach
-- We have customers numbers in order table
-- Which means customer numbers in order table are the customers who purchased at least one time
-- You might think of getting the average order ids per customer it's not feasible in single query
-- First we need to get the order counts per each customer. Then get average over it

WITH order_counts AS (
SELECT
	customernumber,
    COUNT(DISTINCT ordernumber) as order_count
FROM
	orders
GROUP BY
	1
)

SELECT
	ROUND(AVG(order_count), 2) as average_orders_per_purchasing_customer
FROM
	order_counts
    
-- That was simple. See you in the next KPI.