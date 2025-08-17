-- KPI 2 — Customer Lifetime Value (CLV / LTV)
-- Total historical revenue per customer (sum of what the customer spent)
-- Produce the top 5 customers by total lifetime spend, showing customerNumber, customerName, total_revenue.

-- How to approach
-- Here we need customers and their spend. So we need customers table. Their ordered quantity and price or their payments could be a proxy for their spendcustomers
-- We need customer's revenue. So we need to go down the orders path
-- That means we can get customer details from customers table and revenue details from orderdetails table. orders table should be use as the link between these tables.customers
-- Let's first build a query for joining these tables
-- Since this is customer oriented and we don't need orpahn orders where no customers tagged (could happen). We use inner join and center our join around customer table

--SELECT
--	c.customernumber,
--    c.customername,
--    o.ordernumber,
--    od.quantityordered,
--    od.priceeach
--FROM 
--	customers c
--JOIN 
--	orders o USING(customernumber)
--JOIN
--	orderdetails od USING (ordernumber)

-- OK. now we have the fields we need. Now we have to get their total revenue. 
-- Revenue is the quantity ordered * price each. Getting sum of this will get us the revenue. 
-- Do we need a group by? certainly. We need revenue per each customer. So we need to group by customer.
-- How should we group? It's safe to group by customer number since there might be customers with same name. 
-- But we need customer number and the name. So the best approach should be group by customer number and then name
    
SELECT
	c.customernumber,
    c.customername,
    SUM(od.quantityordered * od.priceeach) AS total_revenue
FROM 
	customers c
JOIN 
	orders o USING(customernumber)
JOIN
	orderdetails od USING (ordernumber)
GROUP BY
	1, 2
ORDER BY 
	3 DESC
    
-- Fantastic. Let's meet on the next KPI calculation!