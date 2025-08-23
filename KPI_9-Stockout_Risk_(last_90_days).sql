-- Definition (plain): Sales in last 90 days divided by current stock. Higher than 1 => sold more than available stock in last 90 days (high risk).

-- Why it matters: Prioritize reorders to prevent lost sales.

-- Task: Compute qty_last_90d / quantityInStock per product; show top risky products.

-- How to approach
-- We can get quantity from orderdetails. To get the date we need to use orders table
-- We need to include product table to see which products are running out 
-- We'll try to write this in a single query without CTEs 

WITH cutoff AS (
SELECT DATE(MAX(orderdate), '-90 days') as cutoff_date FROM orders 
)

SELECT
	p.productCode,
    p.productName,
    p.quantityInStock,
    SUM(CASE WHEN o.orderDate > (SELECT cutoff_date FROM cutoff) THEN od.quantityOrdered ELSE 0 END) as qty_last_90_days,
    SUM(CASE WHEN o.orderDate > (SELECT cutoff_date FROM cutoff) THEN od.quantityOrdered ELSE 0 END) / p.quantityInStock AS stockout_risk
FROM
	products p
LEFT JOIN
	orderdetails od USING(productcode)
LEFT JOIN
	orders o USING(orderNumber)
GROUP BY 
	1, 2, 3
ORDER BY
	5 DESC

-- Well. That was something. Let's go to next KPI

