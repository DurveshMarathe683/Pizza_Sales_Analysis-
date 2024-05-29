--  Calculate the percentage contribution of each pizza type to total revenue.
select 
			category,
            round((sum(per_revenue) / total_revenue ) * 100,2) as contribution_percentage
from 
			(SELECT 
				pt.category as category, 
                p.price * od.quantity AS per_revenue,
                sum(p.price * od.quantity)over() as total_revenue
			FROM
				order_details od
			JOIN pizzas p USING (pizza_id)
			JOIN pizza_types pt USING (pizza_type_id)) as revenue
group by 
			category, total_revenue;

            
--  Analyze the cumulative revenue generated over time
select 
			date,
            sum(cost) over(order by date)
from 
		(select 
			o.order_date as date,
            round(sum(od.quantity*p.price),2) as cost
from 
			order_details od join pizzas p using (pizza_id)
            join orders o using (order_id)
group by o.order_date) as revenue;
            


--  Determine the top 3 most ordered pizza  types based on revenue for each pizza category.
WITH pizza_revenue AS (
    SELECT 
        pt.category, 
        pt.name, 
        SUM(od.quantity * p.price) AS revenue
    FROM 
        pizza_types pt
    JOIN 
        pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN 
        order_details od ON od.pizza_id = p.pizza_id
    GROUP BY 
        pt.category, pt.name
),
ranked_pizza AS (
    SELECT
        category,
        name,
        revenue,
        DENSE_RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rnk
    FROM
        pizza_revenue
)
SELECT
    category,
    name,
    revenue
FROM
    ranked_pizza
WHERE
    rnk <= 3
ORDER BY
    category,
    rnk;
 
 
