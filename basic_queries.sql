-- Retrieve total numbers of orders placed
SELECT 
    COUNT(order_id) AS total_orders_count
FROM
    orders;
-- Calculate the total revenue generated from Pizza Sales
SELECT 
    pizza_id,
    ROUND(SUM((od.quantity * p.price)), 2) AS total_cost
FROM
    order_details od
        JOIN
    pizzas p USING (pizza_id)
GROUP BY pizza_id;
-- Highest Pizza prize
SELECT 
    pt.name, p.price
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p USING (pizza_type_id)
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            pizzas);
-- get most common pizza size ordered
SELECT 
    p.size, COUNT(p.size) AS order_count
FROM
    pizzas p
        JOIN
    order_details od USING (pizza_id)
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;
-- list top 5 most ordered pizza types along with their quantities
SELECT 
    pt.name, SUM(od.quantity) AS qt_count
FROM
    order_details od
        JOIN
    pizzas p USING (pizza_id)
        JOIN
    pizza_types pt USING (pizza_type_id)
GROUP BY pt.name
ORDER BY qt_count DESC
LIMIT 5;
                        