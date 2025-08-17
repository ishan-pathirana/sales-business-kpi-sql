-- Calculate following
-- Total revenue
-- Total units sold
-- Total orders
-- Average order value

-- How to approach and think
-- revenue means the unit price * ordered quantity for a particular product. Then I should first find where to get the quantity and unit price
-- orderdetails table contains quantityOrdered and priceEach. I can start there

--SELECT 
--    quantityordered * priceEach AS total_revenue
--FROM 
--    orderdetails;
    
-- NICE! We have total revenue for each order. Not for all orders. If we get the sum of these revenues, we get the total revenuecustomers
-- But don't we need a GROUP BY clause if we use SUM? No. Not if you want sum of groups. If you don't put a GROUP BY, It will return the aggregation for the whole selection
-- So we'll write this

--SELECT 
--	SUM(quantityordered * priceeach) AS total_revenue
--FROM
--	orderdetails

-- Next is total units sold. We have ordered quantity for each order (quantityOrdered) Summing this would give us the required result

--SELECT 
--	SUM(quantityordered * priceeach) AS total_revenue,
--  	SUM(quantityordered) AS total_units_sold  
--FROM
--	orderdetails
    
-- Ok. 2 more to go. Next is total orders. Wouldn't the count of all rows of orderdetails give the number of orders? Well.. No!
-- Why? Because orderdetails record contails details per product per order. That means there could be 1 or more rows per order, with different products.
-- Then how can we get the number of orders? Should we join the orders table? Not necessary. 
-- If we get the number of distinct count of order numbers from order details, it would give what we want

--SELECT 
--	SUM(quantityordered * priceeach) AS total_revenue,
--  	SUM(quantityordered) AS total_units_sold,
--    COUNT(DISTINCT ordernumber) AS total_orders
--FROM
--	orderdetails
    
-- Great! One more to go. Average order value. You guessed it. Use AVG() you say? Woah! Hold your horses buddy
-- Now think carefully. We can get the revenue per each line of orderdetails. That's order value per product per order
-- If we run AVG() we'll get average value of per product per order. That's not what we want.
-- What we need is total revenue, and then divide it by number of orders
-- Good news, we have both already. Don't forget to round the number to 2 decimal places

SELECT 
	SUM(quantityordered * priceeach) AS total_revenue,
  	SUM(quantityordered) AS total_units_sold,
    COUNT(DISTINCT ordernumber) AS total_orders,
    ROUND(SUM(quantityordered * priceeach) / COUNT(DISTINCT ordernumber), 2) as avg_order_value
FROM
	orderdetails
    
-- Well done! We've got all the basics. See you on the next one.