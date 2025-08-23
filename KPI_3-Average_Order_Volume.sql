-- Definition (plain): Average amount customers spend when they place an order.
-- Why it matters: AOV helps set pricing and bundles/upsell targets; marketing uses it to compute expected revenue per new order.
-- Task: Compute AOV = total revenue / total unique orders.

-- How to approach
-- This does not need customer table. We need orderdetails table
-- This KPI does not need to be calculated for each customer. So it's a single value
-- Revenue is quantityordered * priceeach. Getting SUM of this calculation yields total revenue
-- Getting SUM of distinct order ids would give the number of orders in the orderdetails table

SELECT
	ROUND(SUM(quantityordered * priceeach) / COUNT(DISTINCT ordernumber), 2) AS AOV
FROM
	orderdetails
    
    
-- Well, that was easy isn't it? See you in the next KPI!