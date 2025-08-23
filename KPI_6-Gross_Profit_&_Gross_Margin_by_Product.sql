-- Definition (plain):

-- Gross Profit per product = SUM((priceEach − buyPrice) × quantityOrdered)

-- Gross Margin = Gross Profit / Revenue

-- Why it matters: Tells which SKUs actually make money (not only sell a lot). Use for catalog pruning and promotions.

-- Task: For each product, compute revenue, gross_profit, gross_margin; show top 10 by gross_profit.

-- How to approach
-- We need products table and orderdetails table
-- Joining product table with orderdetails table and then gettiing aggregations shold be the way to solve
-- Revevnue is priceeach * quantitiyordered

SELECT
	p.productCode,
    p.productName,
    SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) AS gross_profit_per_product,
    SUM(((od.priceEach - p.buyPrice) * od.quantityOrdered)) / SUM(od.priceEach * od.quantityOrdered) AS gross_margin
FROM
	orderdetails od
JOIN
	products p USING (productcode)
GROUP BY
	1, 2
ORDER BY 
	3 DESC
    
-- That's all. Let's see in the next KPI
    
    
	