SET SQL_SAFE_UPDATES=0;
use classicmodels;

#1. Write a SQL query to show average number of orders shipped in a day (use Orders table).
create temporary table Q1(select count(shippedDate) as shippedOrders, shippedDate from orders group by shippedDate);
select * from Q1; 
select avg(shippedOrders) from Q1;

#alterative solution
select (sum(quantityOrdered)/count(distinct shippedDate)) as shippedorder_per_day 
from orders,orderdetails
where orders.orderNumber=orderdetails.orderNumber and orders.status = 'Shipped' ;

# 2. Write a SQL query to show average number of orders placed in a day.
create temporary table Q2(select count(shippedDate) as ordered, orderDate from orders group by orderDate);
select * from Q2; 
select avg(ordered) from Q2;

#alternative solution
select (sum(quantityOrdered)/count(distinct orderDate)) as order_per_day 
from orders, orderdetails
where orders.orderNumber=orderdetails.orderNumber;

# 3. Write a SQL query to show the product name with minimum MSRP (use Products table).
select productName, MSRP from products where MSRP = (select min(MSRP) from Products);

# 4. Write a SQL query to show the product name with maximum value of stockQuantity.
select productName, quantityInStock from products where quantityInStock = (select max(quantityInStock) from Products);

# 5. Write a query to show the most ordered product Name (the product with maximum number of orders).
create temporary table Q5(select sum(quantityOrdered) as num, productCode from orderdetails group by productCode);
select productName from products where productCode = (select productCode from Q5 where num = (select max(num) from Q5)) ; 

#Alternative method
select productName from  products,orderdetails where orderdetails.productCode=products.productCode group by productName order by sum(quantityOrdered) desc limit 1;

# 6. Write a SQL query to show the highest paying customer Name.
create table Q6(select sum(amount) as num, customerNumber from payments group by customerNumber);
select customerName from customers where customerNumber = (select customerNumber from Q6 where num = (select max(num) from Q6));
#Alternative method
select customerName from payments, customers where payments.customerNumber=customers.customerNumber group by customerName order by sum(amount) desc limit 1;

# 7. Write a SQL query to show cutomerNumber, customerName of all the customers who are from Melbourne city.
select customerNumber, customerName from customers where city = 'Melbourne';

# 8. Write a SQL query to show name of all the customers whose name start with “N”.
select customerName from customers where customerName like 'N%';

# 9. Write a SQL query to show name of all the customers whose phone start with ‘7’ and are from city ‘Las Vegas’.
select customerName, phone, city from customers where phone like '7%' and city = 'Las Vegas';

# 10. Write a SQL query to show name of all the customers whose creditLimit < 1000 and city is either “Las Vegas” or ”Nantes” or “Stavern”.
select customerName, city, creditLimit from customers where creditLimit < 1000 and (city = 'Las Vegas' or  city = 'Nantes' or city ='Stavern');

# 11. Write a SQL query to show all the orderNumber in which quantity ordered <10.
select orderNumber, quantityOrdered from orderdetails where quantityOrdered < 10;

# 12. Write a SQL query to show all the orderNumber whose customer Name start with letter ‘N’.
create temporary table Q12(select customers.customerNumber, customers.customerName, orders.orderNumber
from customers 
join orders on customers.customerNumber = orders.customerNumber);
select * from Q12 where customerName like 'N%';

#Alternate method
select orderNumber from orders, customers where orders.customerNumber = customers.customerNumber and customerName like 'N%';

# 13. Write a SQL query to show all the customerName whose orders are “Disputed” in status.
create temporary table Q13(select customers.customerNumber, customers.customerName, orders.status, orders.orderNumber
from customers 
join orders on customers.customerNumber = orders.customerNumber);
select * from Q13 where status = 'Disputed';

#Alternate method
select customerName from customers, orders where customers.customerNumber = orders.customerNumber and status ='Disputed' ;

# 14. Write a SQL query to show the customerName who made payment through cheque with checkNumber starting with H and made payment on “2004-10-19”.
select customerName from customers where customerNumber = (select customerNumber from payments where checkNumber like 'H%' and paymentDate = '2004-10-19');

# 15. Write a SQL query to show all the checkNumber whose amount > 1000.
select checkNumber from payments where amount < 1000;