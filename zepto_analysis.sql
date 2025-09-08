drop table if exists zepto;

create table zepto (
	sku_id SERIAL PRIMARY KEY,
	category varchar(150),
	name varchar(250) not null,
	mrp numeric(8,2),
	discountPercent numeric(5,2),
	availableQuantity INTEGER,
	discountedSellingPrice numeric(8,2),
	weightInGms INTEGER,
	outOfStock Boolean,
	quantity INTEGER
);

select * from zepto;

--count no. of rows
select count(*) from zepto;

--Data Exploration and Cleaning

--Finding null values

select * from zepto
where category is null
or
	name is null
or
	mrp is null	
or	
	discountPercent	is null
or	
	availableQuantity is null
or 	
	discountedSellingPrice is null
or 
	weightInGms is null
or
	outOfStock is null
or 
	quantity is null;

--Product categories
select distinct category 
from zepto
order by category

--products with price  = 0
select * from zepto
where mrp = 0 or discountedSellingPrice = 0

delete from zepto 
where mrp = 0 or discountedSellingPrice = 0


update zepto 
set mrp = mrp/100.00,
discountedSellingPrice = discountedSellingPrice/100.00

select mrp, discountedSellingPrice from zepto


--Data Analysis--

--Q1. Find the top 10 best-value products based on the discount percentage.
--Q2.What are the Products with High MRP but Out of Stock.
--Q3.Calculate Estimated Revenue for each category.
--Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
--Q5. Identify the top 5 categories offering the highest average discount percentage,
--Q6. Find the price per gram for products above 100g and sort by best value.
--Q7.Group the products into categories like Low, Medium, Bulk.
--Q8.What is the Total Inventory Weight Per Category.
--Q9.Identify top 5 products with the highest margin (MRP - discounted price).
--Q10. Which products contribute the most revenue overall?


--Q1. Find the top 10 best-value products based on the discount percentage.
select name, mrp, discountPercent
from zepto
order by discountPercent desc
limit 10;

--Q2.What are the Products with MRP more than 100₹ but Out of Stock
select distinct name, mrp
from zepto 
where outOfStock is true and mrp >= 100
order by mrp desc;

--Q3.Calculate Estimated Revenue for each category.
select category, sum(discountedSellingPrice * availablequantity) as total_revenue
from zepto
group by category
order by total_revenue;

--Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
select name, mrp, discountpercent from zepto
where mrp > 500 and discountpercent < 10
order by mrp desc, discountpercent desc;

--Q5. Identify the top 5 categories offering the highest average discount percentage.
select category, round(avg(discountpercent, 2)) as average_discount
from zepto
group by category
order by average_discount desc
limit 5;

--Q6. Find the price per gram for products above 100g and sort by best value.
select name, round(discountedSellingPrice/weightingms, 2) as price_per_gram 
from zepto 
where weightingms >= 100
order by price_per_gram desc;

--Q7.Group the products into categories like Low, Medium, Bulk with respect to their weights.
select distinct name, weightingms,
case 
	when weightingms < 1000 then 'light'
	when weightingms < 5000 then 'medium'
	else 'bulk'
end as weight_category
from zepto
order by weightingms desc;

--Q8.What is the Total Inventory Weight Per Category 
select category,
sum(weightingms * availablequantity) as total_inventory_weight
from zepto
group by category
order by total_inventory_weight desc;

--Q9.Identify top 5 products with the highest margin (MRP - discounted price).
select distinct name,
mrp, discountedSellingPrice,
round(mrp - discountedSellingPrice,2) as highest_margin
from zepto 
order by highest_margin desc
limit 5;

--Q10. Identify top 10 products which contribute the most revenue overall?
select name, sum(discountedSellingPrice * availablequantity) as revenue
from zepto
group by name
order by revenue desc
limit 10;