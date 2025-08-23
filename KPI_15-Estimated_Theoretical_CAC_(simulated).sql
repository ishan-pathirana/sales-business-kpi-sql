-- Definition: Average marketing cost per new customer. Because the DB lacks marketing spend, we simulate.

-- Why: Shows how to compute CAC if you had marketing spend 

-- Task: Assume marketing spend $200,000 per year. For each year in data, compute number of customers whose first order is that year, then CAC = 200,000 / new_customers.

-- How to approach
-- We have the customernumber, orderdate in orders table

with customer_first_year AS (
SELECT 
	 customernumber,
     strftime('%Y', MIN(orderdate)) as first_year
FROM 
	orders
GROUP BY 
	1
)

SELECT 
	first_year,
   	COUNT(customernumber) AS new_customer_count,
    ROUND(200000.0 / COUNT(customernumber), 2) AS CAC
FROM 
	customer_first_year
GROUP BY
	1
    
-- Great! This is the end of KPI excercises. Thank you!