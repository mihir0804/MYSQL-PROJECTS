create database Vision_Heaven;
use Vision_Heaven;

CREATE TABLE Customer (
    Customer_id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_name VARCHAR(50) NOT NULL,
    Customer_email VARCHAR(100) UNIQUE NOT NULL,
    Customer_phoneno VARCHAR(15),
    Customer_age INT CHECK (Customer_age >= 18),
    Customer_gender CHAR(1) CHECK (Customer_gender IN ('M', 'F')), 
    Customer_address TEXT,
    Customer_password VARCHAR(255) NOT NULL
);

CREATE TABLE Products (
    Product_id INT PRIMARY KEY AUTO_INCREMENT,
    Product_name VARCHAR(100),
    Product_brand VARCHAR(50),
    Product_type VARCHAR(50),
    Product_colour VARCHAR(30),
    Product_frametype VARCHAR(50),
    Product_lenstype VARCHAR(50),
    Product_material VARCHAR(50),
    Product_desc TEXT
);

CREATE TABLE Orders (
    Order_id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_id INT,
    Order_date DATE,
    Order_status VARCHAR(20),
    Shipping_address VARCHAR(255), 
    Total_amount DECIMAL(18, 2),
    Payment_method VARCHAR(50),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

CREATE TABLE OrderItem (
    Orderitem_id INT PRIMARY KEY AUTO_INCREMENT, 
    Order_id INT,
    Product_id INT,
    Item_price DECIMAL(18, 2),
    Quantity INT,
    Item_total_price DECIMAL(18, 2) GENERATED ALWAYS AS (Item_price * Quantity) STORED,
    FOREIGN KEY (Order_id) REFERENCES Orders(Order_id),
    FOREIGN KEY (Product_id) REFERENCES Products(Product_id)
);

CREATE TABLE Carts (
    Cart_id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_id INT,
    Creation_date DATE,
    Update_date DATE,
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

CREATE TABLE CartItem (
    Cartitem_id INT PRIMARY KEY AUTO_INCREMENT, 
    Cart_id INT,
    Product_id INT,
    Item_price DECIMAL(18, 2),
    Quantity INT,
    FOREIGN KEY (Cart_id) REFERENCES Carts(Cart_id),
    FOREIGN KEY (Product_id) REFERENCES Products(Product_id)
);

CREATE TABLE Payment (
    PaymentId INT PRIMARY KEY AUTO_INCREMENT,
    Order_id INT,
    Paymentdate DATE,
    Paymentamount DECIMAL(18, 2),
    Paymentmethod VARCHAR(50),
    Paymentstatus VARCHAR(20),
    Customer_id INT,
    FOREIGN KEY (Order_id) REFERENCES Orders(Order_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

CREATE TABLE Reviews (
    Review_id INT PRIMARY KEY AUTO_INCREMENT,
    Product_id INT,
    Customer_id INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    Postdate DATE,
    FOREIGN KEY (Product_id) REFERENCES Products(Product_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

INSERT INTO Customer (Customer_name, Customer_email, Customer_phoneno, Customer_age, Customer_gender, Customer_address, Customer_password) 
VALUES 
('Ajit Pandey', 'ajitpandey@gmail.com', '9819978432', 28, 'M', 'Mumbai, India', 'passwordAjit123'),
('Chirag Wamanacharya', 'chiragwamanacharya@gmail.com', '9876543210', 35, 'M', 'Delhi, India', 'passwordChirag456'),
('Priya Mehta', 'priyamehta@gmail.com', '9819978434', 24, 'F', 'Bangalore, India', 'passwordPriya789'),
('Rajesh Iyer', 'rajeshiyer@gmail.com', '9819978435', 35, 'M', 'Chennai, India', 'passwordRajesh321'),
('Anjali Desai', 'anjalidesai@gmail.com', '9819978436', 30, 'F', 'Pune, India', 'passwordAnjali654'),
('Vikram Kapoor', 'vikramkapoor@gmail.com', '9819978437', 27, 'M', 'Hyderabad, India', 'passwordVikram987'),
('Sneha Rao', 'sneharao@gmail.com', '9819978438', 22, 'F', 'Kolkata, India', 'passwordSneha123'),
('Nilam Shah', 'nilam.shah@email.com', '1122334455', 30, 'F', 'Ahmedabad, India', 'passwordNilam111');

INSERT INTO Products (Product_name, Product_brand, Product_type, Product_colour, Product_frametype, Product_lenstype, Product_material, Product_desc) 
VALUES 
('Aviator Sunglasses', 'Ray-Ban', 'Eyewear', 'Black', 'Metal', 'Polarized', 'Aluminium', 'Classic aviator sunglasses'),
('Wayfarer Sunglasses', 'Oakley', 'Eyewear', 'Brown', 'Plastic', 'Non-Polarized', 'Plastic', 'Trendy wayfarer style'),
('Round Glasses', 'Gucci', 'Eyewear', 'Gold', 'Metal', 'Anti-glare', 'Titanium', 'Premium round glasses'),
('Sports Sunglasses', 'Nike', 'Eyewear', 'Red', 'Plastic', 'UV Protection', 'Polycarbonate', 'Perfect for outdoor sports'),
('Blue Light Glasses', 'Titan', 'Eyewear', 'Blue', 'Metal', 'Blue Light Filter', 'Aluminium', 'Reduces screen glare'),
('Cat Eye Glasses', 'Prada', 'Eyewear', 'Pink', 'Plastic', 'Gradient', 'Acetate', 'Fashionable cat eye design'),
('Oversized Glasses', 'Versace', 'Eyewear', 'Silver', 'Metal', 'Photochromic', 'Stainless Steel', 'Oversized modern look'),
('Retro Glasses', 'Fastrack', 'Eyewear', 'Green', 'Plastic', 'Tinted', 'Resin', 'Retro-inspired stylish glasses');

INSERT INTO Orders (Customer_id, Order_date, Order_status, Shipping_address, Total_amount, Payment_method) 
VALUES 
(1, '2024-03-01', 'Shipped', 'Mumbai, India', 2999.99, 'Credit Card'),
(2, '2024-03-02', 'Delivered', 'Delhi, India', 1599.50, 'Debit Card'),
(3, '2024-03-03', 'Processing', 'Bangalore, India', 2200.00, 'UPI'),
(4, '2024-03-04', 'Shipped', 'Chennai, India', 1899.75, 'Net Banking'),
(5, '2024-03-05', 'Cancelled', 'Pune, India', 3499.00, 'Credit Card'),
(6, '2024-03-06', 'Delivered', 'Hyderabad, India', 2700.80, 'PayPal'),
(7, '2024-03-07', 'Processing', 'Kolkata, India', 1200.99, 'Cash on Delivery'),
(8, '2024-03-08', 'Shipped', 'Ahmedabad, India', 3150.45, 'Debit Card');

INSERT INTO OrderItem (Order_id, Product_id, Item_price, Quantity) 
VALUES 
(1, 1, 2999.99, 1),
(2, 2, 1599.50, 1),
(3, 3, 1100.00, 2),
(4, 4, 1899.75, 1),
(5, 5, 3499.00, 1),
(6, 6, 2700.80, 1),
(7, 7, 1200.99, 1),
(8, 8, 3150.45, 1);

INSERT INTO Carts (Customer_id, Creation_date, Update_date) 
VALUES 
(1, '2024-02-25', '2024-02-28'),
(2, '2024-02-26', '2024-02-28'),
(3, '2024-02-27', '2024-03-01'),
(4, '2024-02-28', '2024-03-02'),
(5, '2024-03-01', '2024-03-03'),
(6, '2024-03-02', '2024-03-04'),
(7, '2024-03-03', '2024-03-05'),
(8, '2024-03-04', '2024-03-06');

INSERT INTO CartItem (Cart_id, Product_id, Item_price, Quantity) 
VALUES 
(1, 1, 2999.99, 1),
(2, 2, 1599.50, 1),
(3, 3, 1100.00, 2),
(4, 4, 1899.75, 1),
(5, 5, 3499.00, 1),
(6, 6, 2700.80, 1),
(7, 7, 1200.99, 1),
(8, 8, 3150.45, 1);


INSERT INTO Payment (Order_id, Paymentdate, Paymentamount, Paymentmethod, Paymentstatus, Customer_id) 
VALUES 
(1, '2024-03-01', 2999.99, 'Credit Card', 'Success', 1),
(2, '2024-03-02', 1599.50, 'Debit Card', 'Success', 2),
(3, '2024-03-03', 2200.00, 'UPI', 'Pending', 3),
(4, '2024-03-04', 1899.75, 'Net Banking', 'Success', 4),
(5, '2024-03-05', 3499.00, 'Credit Card', 'Failed', 5),
(6, '2024-03-06', 2700.80, 'PayPal', 'Success', 6),
(7, '2024-03-07', 1200.99, 'Cash on Delivery', 'Pending', 7),
(8, '2024-03-08', 3150.45, 'Debit Card', 'Success', 8);


INSERT INTO Reviews (Product_id, Customer_id, Rating, Comment, Postdate) 
VALUES 
(1, 1, 5, 'Excellent quality!', '2024-03-10'),
(2, 2, 4, 'Very stylish sunglasses', '2024-03-11'),
(3, 3, 5, 'Perfect for my needs', '2024-03-12'),
(4, 4, 3, 'Could be better', '2024-03-13'),
(5, 5, 4, 'Really nice lenses', '2024-03-14'),
(6, 6, 5, 'Amazing design and comfort', '2024-03-15'),
(7, 7, 2, 'Not what I expected', '2024-03-16'),
(8, 8, 5, 'Best purchase ever!', '2024-03-17');

alter table customer
add column date_of_Birth date;

alter table customer
modify customer_name varchar(100);

alter table customer
drop column date_of_birth;

desc customer;

alter table customer
add constraint unique (customer_phoneno);

select customer_name,customer_email
from customer;

select * from customer;

select customer_name,customer_age
from customer
where customer_age >25;

select customer_name,customer_age
from customer
order by customer_age asc;

select order_id,total_amount
from orders
order by total_amount desc;

select Customer_name,Customer_age,Customer_address
from Customer
where Customer_age >25 AND Customer_address='kalyan west';

update  customer
set customer_address='101,East Ave,City, Country'
where customer_id=8;
select * from customer;

select Customer_name,Customer_age,Customer_address
from customer
where Customer_age >25 OR Customer_address='Dadar';

select customer_name,customer_age,customer_address
from customer
where NOT customer_address ='Borivali';

select customer_name, customer_age
from customer
where Customer_age BETWEEN 20 AND 30;

select customer_name
from customer
where customer_name like 'A%';

select order_id,payment_method
from orders
where payment_method in('paypal','credit card','bank transfer');

update  orders
set payment_method='Bank Transfer'
where order_id=7;

select Item_price + Quantity as Total_Cost
from Cartitem;

select Item_price - (Item_price * Quantity) as Remaining_Amount
from cartitem;

select item_price * Quantity as Total_price
from cartitem;
select * from cartitem;

select Item_price / Quantity as avg_price_per_item
from cartitem;

select total_amount % 10 as Remainder
from orders;

select * from orders
where customer_id =1;

select * from products
where product_name!='Round glasses';

select * from orders
where total_amount < 2000;

select * from orders
where total_amount<=1300;

select distinct order_status
from orders;

select customer_id,customer_name,customer_email
from customer
limit 5;

INSERT INTO Customer ( Customer_name, Customer_email, Customer_phoneno,
Customer_age, Customer_gender, Customer_address, Customer_password)
VALUES
( 'Amit Desai', 'amit.desai@email.com', '5566778899', 40, 'M', '505 Central Ave, City, Country', 'password55');



INSERT INTO Customer (Customer_name, Customer_email, Customer_phoneno, Customer_age, Customer_gender, Customer_address, Customer_password)
VALUES('Boby Roy', 'boby.roy@email.com', '5546677899', 45, 'M', '515 Central Ave, City, Country', 'password585'),
 ('Sneha Reddy', 'sneha.reddy@email.com', '6677889900', 26, 'F', '606 Maple St, City, Country', 'password666');
 
 update customer
 set customer_email='ajitpandey123@gmail.com'
 where customer_id=1;
 select * from customer;
 
 update customer
 set customer_phoneno='7798805101' , customer_age=40
 where customer_id=2;
 
 update customer
 set customer_age=45
 where customer_gender='f';
 
 delete from customer
 where customer_id=12;
 
 delete from customer;
 
 select concat(customer_name, '-' ,customer_email) as customer_details
 from customer;
 
 select lower(customer_name) as lower_case_cust_name
 from customer;
 
 select customer_name,length(customer_name) as customer_length
 from customer;
 
 select customer_name,substring(customer_name,1,5) as Substring_name
 from customer;
 
 select count(*) as total_rows_in_customer_table
 from customer;
 
 select sum(total_amount) as total_sum
 from orders;
 
 select * from customer;
 select avg(total_amount) as avg_amount
 from orders;
 
 select min(total_amount) as minimumn_total
 from orders;
 
 select max(total_amount) as maximum_total
 from orders;
 
 select count(*) as total_orders,
 sum(total_amount) as total_revenue,
 min(total_amount) as minimum_order,
 max(total_amount) as maximum_order,
 avg(total_amount) as avg_of_order
 from orders;
 
 
 select c.customer_id ,p.paymentmethod
 from customer c join payment p on c.customer_id=p.customer_id
 where p.paymentmethod=(select paymentmethod
							from payment
                            where customer_id=4);
					
select c.customer_name
from customer c
where c.customer_id in (select o.customer_id
					from orders o
                    where o.order_status in ('shipped','pending'));

select c.customer_name,o.order_id
from customer c right join orders o on c.customer_id=o.customer_id;
                            
 select c.customer_name,p.product_id
 from customer c cross join products p;
 
 create view customer_view
 as 
 select customer_name,customer_email,customer_phoneno
 from customer;
 select * from customer_view;
 
 create view customer_view2 as
 select c.customer_id, c.customer_name,o.order_id,sum(o.total_amount)as total_spent
 from customer c join orders o on c.customer_id=o.customer_id
 group by c.customer_name,c.customer_id,o.order_id;
 select * from customer_view2;
 drop view customer_view2;
 
 delimiter //
 create procedure order_detail()
 begin
 select order_id,customer_id,order_status
 from orders;
 end //
 delimiter ;
 
 
 call order_detail();
 
 
 alter table orders
 add constraint fk foreign key(order_id) references customer(order_id);
 
 alter table orders
 drop constraint fk;
 
 select c.customer_id,o.order_id,p.paymentid
 from customer c
 join orders o on (c.customer_id=o.customer_id)
 join payment p on (o.customer_id=p.customer_id);
 
 
 
 
 select * from payment;
 
 update customer
 set customer_phoneno='7798805145' , Customer_age=78
 where customer_id=7;
 
 select * from customer;
 
 desc customer;
 desc orders;
 
 select c.customer_id,o.order_id
 from customer c inner join orders o
 on c.customer_id=o.customer_id;
 
 create or replace view customer_view3
 as
 select customer_id,customer_name,customer_age
 from customer;