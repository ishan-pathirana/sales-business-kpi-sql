-- Definition: How many times inventory would have been sold over dataset period. Simple version: total_units_sold / SUM(quantityInStock).

-- Why: Understand turnover rate; high turnover = fast selling, low turnover = slow-moving stock.

-- Task: Compute total units sold across products / total current stock.

-- How to approach
-- We need orderdetails table to get the total units sold 
-- And we need products table to get the current stock for a particular product
-- Getting summation of those 2 and then getting division would yield the result we need

with product_units_sold as (
SELECT
	p.productCode,
    p.quantityInStock,
    SUM(od.quantityOrdered) AS units_sold
FROM
	orderdetails od
JOIN
	products p USING(productcode)
GROUP BY
	1, 2
)

SELECT 
	ROUND(SUM(units_sold) * 1.0 / SUM(quantityinstock), 2) AS inventory_turnover
FROM
	product_units_sold
    
-- Nice. Let's go to the next KPI