-- INNER JOIN 
SELECT *FROM customer;
SELECT *FROM products;
SELECT *FROM purchase_history;
-- 1. Write a query to get the first_name, last_name, and email of all customers who have made at least one purchase.
SELECT c.first_name ,c.last_name ,c.email 
from customer c
inner join purchase_history ph
on c.customer_id = ph.customer_id;

-- 2. List the product_name and price_per_unit for products that have been purchased by at least one customer. 
SELECT distinct p.product_name ,p.price_per_unit 
FROM products p 
inner join purchase_history ph
on p.product_id = ph.product_id;

-- 3. Find the first_name, last_name, and purchase_date for customers who have made a purchase.
select c.first_name ,c.last_name ,ph.purchase_date
from customer c 
inner join purchase_history ph
on c.customer_id = ph.customer_id;

-- 4.Write a query to list the first_name, last_name, and product_name for customers who have bought more than 3 units of a product in a single purchase.
 select c.first_name ,c.last_name ,p.product_name 
 from customer c 
 inner join purchase_history ph
 on c.customer_id = ph.customer_id
 inner join products p
 on p.product_id = ph.product_id
 where ph.quantity > 3;
 
 -- 5. Retrieve the first_name, last_name, product_name, and total_amount for all customers who spent more than $500 in a single purchase. 
  select c.first_name ,c.last_name ,p.product_name ,sum(ph.total_amount) AS total_amount
 from customer c 
 inner join purchase_history ph
 on c.customer_id = ph.customer_id
 inner join products p
 on p.product_id = ph.product_id
GROUP BY c.first_name, c.last_name, p.product_name
 having sum(ph.total_amount) > 500;
 
 -- 6. Write a query to find the total number of products bought by each customer and the total amount spent on all purchases.
SELECT c.first_name, c.last_name,
SUM(ph.quantity) AS total_products_bought,
SUM(ph.total_amount) AS total_amount_spent
FROM customer c
INNER JOIN purchase_history ph
ON c.customer_id = ph.customer_id
GROUP BY c.first_name, c.last_name;

-- 7. Write a query to list the customers who purchased the highest priced product and the total amount they spent. 
SELECT c.first_name, c.last_name, p.product_name,
SUM(ph.total_amount) AS total_amount_spent
FROM customer c
INNER JOIN purchase_history ph ON c.customer_id = ph.customer_id
INNER JOIN products p ON p.product_id = ph.product_id
WHERE p.price_per_unit = (SELECT MAX(price_per_unit) FROM products)
GROUP BY c.first_name, c.last_name, p.product_name;

-- 8. Write a query that shows the customer_id, product_name, and the quantity purchased for each customer who purchased more than one product. 
SELECT ph.customer_id, p.product_name, ph.quantity
FROM purchase_history ph
INNER JOIN products p
ON ph.product_id = p.product_id
WHERE ph.customer_id IN (
    SELECT customer_id
    FROM purchase_history
    GROUP BY customer_id
    HAVING COUNT(DISTINCT product_id) > 1
);


-- 9. List the total spending per customer and their most expensive product purchased using INNER JOIN.
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(ph.total_amount) AS total_spending,
       p.product_name AS most_expensive_product
FROM customer c
INNER JOIN purchase_history ph
ON c.customer_id = ph.customer_id
INNER JOIN products p
ON ph.product_id = p.product_id
WHERE p.price_per_unit = (
      SELECT MAX(p2.price_per_unit)
      FROM purchase_history ph2
      INNER JOIN products p2
      ON ph2.product_id = p2.product_id
      WHERE ph2.customer_id = c.customer_id
)
GROUP BY c.customer_id, c.first_name, c.last_name, p.product_name;

-- 10. Write a query to find customers who have purchased both from the 'Electronics' and 'Fashion' categories.
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
INNER JOIN purchase_history ph ON c.customer_id = ph.customer_id
INNER JOIN products p ON ph.product_id = p.product_id
WHERE p.category IN ('Electronics', 'Fashion')
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT p.category) = 2;

