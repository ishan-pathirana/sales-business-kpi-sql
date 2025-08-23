-- Definition: Total revenue grouped by month (YYYY-MM) to spot seasonal patterns.

-- Why: Helps plan promotions and staffing; detect slow months.

-- Task: Show revenue per month for all months, ordered chronologically.

-- How to approach
-- We can get revenue from orderdetails table by priceeach * quantitiyordered
-- orders table contains orderdate. This can be used to group by month

SELECT
	strftime('%Y-%m', o.orderDate) as month,
    ROUND(SUM(od.priceEach * od.quantityOrdered), 2) as revenue 
FROM
	orderdetails od
JOIN 
	orders o USING(ordernumber)
GROUP BY 
	1
ORDER BY
	1
    
-- Well, that was easy. Let's go to the next KPI