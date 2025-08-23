-- Definition: For customers who ordered multiple times, compute average span (in days) between their first and last order divided by (order_count - 1). A measure of purchasing cadence.

-- Why: Understand typical repurchase interval to design retention campaigns.

-- Task: For customers with >1 order, compute average days between orders; then compute overall average

-- How to approach
-- First we need the minimum and maximum dates of eachcustomer in orders table
-- Then we can get the days span for each customer 
-- Also we can get the order count - 1 for each customer from orders table
-- With this result we'll divide time span by order count -1 for each customer and get the average of it

WITH customer_order_span as (
SELECT
	customernumber,
    JULIANDAY(MAX(orderdate)) - JULIANDAY(MIN(orderdate)) as days_span,
    COUNT(DISTINCT ordernumber) AS order_count
from 
	orders
GROUP BY 
	1
HAVING 
	COUNT(DISTINCT ordernumber) > 1
)

SELECT
	ROUND(AVG(days_span / (order_count - 1)), 2) as avg_days_between_orders,
    COUNT(*) as repeat_customer_count
FROM
	customer_order_span
    
-- Great! Let's move to the next KPI