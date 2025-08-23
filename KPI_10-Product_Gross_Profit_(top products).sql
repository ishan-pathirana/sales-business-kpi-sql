-- Definition: Total gross profit per product = SUM((priceEach − buyPrice) × qty).

-- Why: Find high-profit SKUs to promote and low-profit ones to review pricing.

-- Task: Rank products by gross profit and show top 10.

-- How to approach
-- We need products table and orderdetails table
-- We can get the priceEach - buyPrice * quantityOrdered and then get the sum and group by product

SELECT 
	p.productCode,
    p.productName,
    ROUND(SUM((od.priceEach - p.buyPrice) * od.quantityOrdered), 2) as gross_profit,
    SUM(od.quantityOrdered) As units_sold
FROM
	orderdetails od
JOIN
	products p USING(productcode)
GROUP BY
	1, 2
ORDER BY 
	3 DESC
LIMIT 10

-- Good. We'll move to the next KPI