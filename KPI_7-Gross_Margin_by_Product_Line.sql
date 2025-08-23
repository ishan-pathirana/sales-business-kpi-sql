-- Definition: Sum of gross profit across all products in a product line/category.

-- Why it matters: Helps decide which categories to grow or cut.

-- Task: Aggregate gross profit per productLine and order by descending margin.

-- How to approach
-- We need products table and orderdetails table
-- For each order we can get the gross profit by (priceeach - buyprice) * quantityordered
-- For each order we can get the gross marging by (priceeach - buyprice) * quantityordered / priceeach * quantityordered
-- Need to get summation over the productline

SELECT
	p.productLine,
    SUM(od.priceEach * quantityordered) as revenue,
    SUM((od.priceEach - p.buyPrice) * od.quantityordered) as gross_profit,
    SUM((od.priceEach - p.buyPrice) * od.quantityordered) / SUM(od.priceEach * od.quantityOrdered) as gross_margin
FROM
	orderdetails od
JOIN 
	products p USING(productcode)
GROUP BY
	1
order BY
	3 DESC
    
-- Ok. Let's move to the next KPI