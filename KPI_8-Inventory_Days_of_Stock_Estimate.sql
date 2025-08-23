-- Definition (plain): How many days current stock will last at historical sales rate:

-- days_of_stock = quantityInStock / (avg_daily_units_sold_for_product)


-- Where avg_daily_units_sold_for_product = total_units_sold_for_product / days_span_of_dataset.

-- Why it matters: Identifies SKUs that will run out soon or are overstocked.

-- Task: Estimate days of stock per product; show items with smallest days_of_stock (most urgent). 

-- How to approach
-- Mainly we need the orderdetails table. We need products table to get product name
-- We also need orders table to get orderdate
-- First we'll calculate the sum of orderedquantity for all the products in orderdetails table
-- That will give us the total units sold for product
-- If we get the min and max days of orders table, that will give us the timespan of all the orders
-- Dividing total units sold for product by timespan will yield avg daily units sold for product
-- Finally we divide the quantity in stock for each product by avg daily units sold per product

WITH total_units as (
SELECT
	productcode,
    SUM(quantityordered) AS total_units_sold_for_products
FROM 
	orderdetails
GROUP BY
	productcode
),
time_span AS (
SELECT (julianday(MAX(orderDate)) - julianday(MIN(orderDate))) as days_span
FROM orders
)

SELECT 
	p.productCode,
    p.productName,
    p.quantityInStock,
    COALESCE(t.total_units_sold_for_products, 0) AS total_units_sold,
    ts.days_span AS days_span,
    COALESCE(t.total_units_sold_for_products, 0) / ts.days_span AS avg_daily_units_sold_for_product,
    p.quantityInStock / (COALESCE(t.total_units_sold_for_products, 0) / ts.days_span) AS days_of_stock
FROM
	products p
LEFT JOIN
	total_units t USING(productcode)
CROSS JOIN
	time_span ts
    
-- That's done. See you at the next KPI