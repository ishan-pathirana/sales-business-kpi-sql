-- Definition (plain): Proportion of customers who placed more than one order.

-- Why it matters: Measures loyalty/retention. Higher RPR implies better customer stickiness and lower reliance on acquisition.

-- Task: Compute RPR = (# customers with >1 orders) / (# customers with ≥1 order).

-- How to approach
-- We only need the calculate a proportion. No need of customer names
-- order table contains the customer id. Also order table contains the orders which has a customer number
-- We can first get order count for each customer number by counting order ids and group by customer number
-- Then we can use a case statement to get the sum of customer numbers with order count > 1
-- If an customer is in order table that meas customers in order table have at least purchased once
-- Therefore getting count of all the customer numbers yields the number of customers with orders >= 1
-- Dividing these 2 things will provide the repeat purchase rate

WITH order_counts AS (
SELECT
    customernumber,
    COUNT(DISTINCT orderNumber) as order_count
FROM
	orders
GROUP BY 
	1
)

SELECT 
	ROUND((SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) * 1.0) / COUNT(customernumber), 2) as repeat_purchase_rate
FROM
	order_counts
    
-- That's was not very complex. See you in the next KPI.