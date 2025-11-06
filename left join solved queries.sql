-- Left join solved queries
select *from customer;
select *from purchase_history;
select *from products;

-- 1. Write a query to list all customers and their purchase details (if available). 
select c.customer_id ,c.first_name 
,c.last_name ,ph.purchase_id ,ph.customer_id 
,ph.purchase_date ,ph.quantity ,ph.total_amount
from customer c 
left join purchase_history ph
on c.customer_id = ph.customer_id;


-- 2. List all products and the quantity purchased by each customer, even if no purchases have been made. 
SELECT p.product_id, p.product_name, c.customer_id, c.first_name, c.last_name, ph.quantity
FROM products p
LEFT JOIN purchase_history ph ON p.product_id = ph.product_id
LEFT JOIN customer c ON ph.customer_id = c.customer_id;


-- 3. Write a query to find all customers who haven't made any purchases. 
select c.customer_id ,c.first_name ,c.last_name
,ph.purchase_id 
from customer c 
left join purchase_history ph
on c.customer_id = ph.customer_id
where ph.purchase_id is null;


-- 4. List all customers and the total amount they spent on purchases, including those who made no purchases.
select c.customer_id ,c.first_name ,c.last_name
,sum(ph.total_amount) as total_spent
from customer c 
left join purchase_history ph
on c.customer_id = ph.customer_id
group by c.customer_id ,c.first_name ,c.last_name;

 
-- 5. Write a query to find products that have not been purchased.
select p.product_id ,p.product_name
,ph.purchase_id
from products p 
left join purchase_history ph
on p.product_id = ph.product_id
where ph.purchase_date is null;

-- 6. Find customers who have purchased products but did not buy from the 'Electronics' category. 
SELECT c.customer_id ,c.first_name ,c.last_name
FROM customer c
LEFT JOIN purchase_history ph 
ON c.customer_id = ph.customer_id
LEFT JOIN products p 
ON ph.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(CASE WHEN p.category = 'Electronics' THEN 1 ELSE 0 END) = 0
AND COUNT(ph.purchase_id) > 0;


-- 7. Write a query to find customers who purchased only products from the 'Fashion' category. 
SELECT c.customer_id ,c.first_name ,c.last_name
FROM purchase_history ph
LEFT JOIN products p 
ON ph.product_id = p.product_id
LEFT JOIN customer c 
ON ph.customer_id = c.customer_id
GROUP BY c.customer_id ,c.first_name ,c.last_name
HAVING MIN(p.category) = 'Fashion'
AND MAX(p.category) = 'Fashion';


-- 8. List all customers who have made purchases and the corresponding product details, but include those who haven't purchased anything. 
SELECT c.customer_id ,c.first_name ,c.last_name
,p.product_id ,p.product_name 
,ph.purchase_id
FROM customer c 
left join purchase_history ph
on c.customer_id = ph.customer_id
left join products p 
on p.product_id = ph.product_id;


-- 9. Write a query to list all products that have been purchased by customers in the 'Electronics' category but exclude customers who have purchased only from the 'Fashion' category. 
select p.product_id ,p.product_name ,p.category
,c.customer_id ,c.first_name ,c.last_name
from products p 
left join purchase_history ph
on p.product_id  = ph.product_id
left join customer c 
on c.customer_id = ph.customer_id
where c.customer_id in ( 
select ph.customer_id 
from products p 
left join purchase_history ph
on p.product_id  = ph.product_id
left join customer c 
on c.customer_id = ph.customer_id
where p.category = 'Electronics'
)

And c.customer_id not in ( 
select ph.customer_id 
from products p 
left join purchase_history ph
on p.product_id  = ph.product_id
left join customer c 
on c.customer_id = ph.customer_id
GROUP BY ph.customer_id
HAVING MIN(p.category) = 'Fashion'
AND MAX(p.category) = 'Fashion'
)


