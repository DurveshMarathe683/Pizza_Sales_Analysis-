-- total order quantity for each pizza category 
SELECT 
    pt.category, SUM(od.quantity) AS order_quantity
FROM
    order_details od
        JOIN
    pizzas p USING (pizza_id)
        JOIN
    pizza_types pt USING (pizza_type_id)
GROUP BY pt.category;
            
-- Determine  the ditribution of orders by hour of day
SELECT 
    HOUR(order_time) AS hours, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY hours;

-- category wise distribution of pizzas
SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;
            
-- group the orders by date and calculate the average no. of pizzas ordered per day
SELECT 
    ROUND(AVG(quantity), 0)
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS quantity
    FROM
        orders o
    JOIN order_details od USING (order_id)
    GROUP BY o.order_date) AS order_per_day;

-- Determine the top 3 pizza types based on the revenue
SELECT 
    name, Total_revenue
FROM
    (SELECT 
        pt.name, SUM(p.price * od.quantity) AS Total_revenue
    FROM
        order_details od
    JOIN pizzas p USING (pizza_id)
    JOIN pizza_types pt USING (pizza_type_id)
    GROUP BY pt.name) tr
ORDER BY total_revenue DESC
LIMIT 3;


            
            
