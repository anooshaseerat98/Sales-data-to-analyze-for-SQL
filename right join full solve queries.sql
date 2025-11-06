--  RIGHT JOIN Practical Questions 
select *from customer;
select *from products;
select *from purchase_history;

-- 1. Write a query to list all products and their purchase details (if available).
select p.product_id ,p.product_name ,p.price_per_unit
,ph.purchase_id ,ph.quantity ,ph.total_amount
from purchase_history ph
right join products p 
on p.product_id = ph.product_id;


-- 2. Find all purchases and their corresponding customer details, even if the customer has not been linked to a purchase. 
select ph.product_id ,ph.purchase_id ,ph.quantity ,ph.total_amount
,c.customer_id ,c.first_name ,c.last_name
from customer c 
right join purchase_history ph
on c.customer_id = ph.customer_id;


-- 3. List all customers and the product names of their purchases, even if some purchases don’t have corresponding customer data. 
select c.customer_id ,c.first_name ,c.last_name
,p.product_name
,ph.quantity
from purchase_history ph
right join customer c
on c.customer_id = ph.customer_id
left join products p 
on p.product_id = ph.product_id;


-- 4. Write a query to list all products purchased by customers, even if some purchases don’t have customer data. 
select p.product_id ,p.product_name 
from products p
right join purchase_history ph
on p.product_id = ph.product_id
left join customer c 
on c.customer_id = ph.customer_id;


-- 5. Write a query to list all products that have been purchased by customers, and include products that have not been purchased.
select p.product_id ,p.product_name 
,ph.purchase_id
from purchase_history ph
right join products p
on p.product_id = ph.product_id;

 
-- 6. List the customer details and product names for customers who have purchased a product but do not have corresponding records in the products table. 
select c.customer_id ,c.first_name ,c.last_name
,p.product_name
,ph.purchase_id
from  products p 
right join purchase_history ph
on p.product_id =ph.product_id 
inner join customer c 
on c.customer_id = ph.customer_id
where p.product_id is null;

