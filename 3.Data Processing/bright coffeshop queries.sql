-------------------------------------------------------------
---Bright Coffee Shop Analysis Case Study 1
-------------------------------------------------------------

---1.running 100 rows from the table 
select * 
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1` limit 100;

---2.checking the date range {6 months}
select MIN(transaction_date) AS first_day,
       MAX(transaction_date) AS last_day 
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---3.checking different store locations (3 stores)
select distinct store_location 
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---4.checking the  product category and product detail (80 product details and 9 product categories ) 
select distinct product_category,
       product_detail
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---5. checking the different product types (29 different types) 
select distinct product_type 
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---6.checking null values in various columns
select *
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
where unit_price is null;

---7.checking the lowest and highest unit_price 
select min(unit_price) AS min_price,
       max(unit_price) AS max_price
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---9.countimg number of stores and sales 
select count(*) as number_of_rows ,
       count (distinct store_id) as number_of_stores,
       count (distinct transaction_id) as number_of_sales,
       count (distinct product_id) as number_of_products
from  `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---10.extracting the day and month names 
select dayname(transaction_date) AS day_name,
       monthname(transaction_date) AS month_name,
       transaction_date
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---11.calculating the total revenue 
select unit_price,
      transaction_qty,
      unit_price*transaction_qty AS total_revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---.12checking the total revenue for each product category
select product_category,
       sum(unit_price*transaction_qty) AS total_revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by product_category;

---13.checking the total revenue for each store location
select store_location,
       sum(unit_price*transaction_qty) AS total_revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by store_location;

---14.combining fuctions to get  a clean and enhanced data set 
select  transaction_date as purchase_date,
      dayname(transaction_date) AS day_name,
      monthname(transaction_date) AS month_name,
      dayofmonth(transaction_date) AS day_of_month,
---new column : determining weekday/weekend 
case when dayname(transaction_date) in ('saturday','sunday') then 'weekend' else 'weekday'
end as day_classification,
 ---date_format(transaction_time,'HH:mm:ss') AS purchase_time      
case when date_format(transaction_time,'HH:mm:ss') between '05:00:00' and '08:59:59' then '1.early morning'
when date_format(transaction_time,'HH:mm:ss') between '09:00:00' and '11:59:59' then '2.late morning'
when date_format(transaction_time,'HH:mm:ss') between '12:00:00' and '15:59:59' then '3.afternoon'
else '5.evening' 
end as time_classification,
  ---count ids 
count(distinct transaction_id) as number_of_sales,
count(distinct product_id) as number_of_products,
count(distinct store_id) as number_of_stores,  
---new column 4:revenue 
sum(transaction_qty*unit_price) AS revenue_per_day,
---categorical columns
       store_location,
       product_category,
       product_detail
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by transaction_date,
         dayname(transaction_date),
         monthname(transaction_date),
         dayofmonth(transaction_date),
         store_location,
case when dayname(transaction_date) in ('saturday','sunday') then 'weekend' 
     else 'weekday'
end,
case when date_format(transaction_time,'HH:mm:ss') between '05:00:00' and '08:59:59' then '1.early morning'
when date_format(transaction_time,'HH:mm:ss') between '09:00:00' and '11:59:59' then '2.late morning'
when date_format(transaction_time,'HH:mm:ss') between '12:00:00' and '15:59:59' then '3.afternoon'
else '5.evening'
end,
         product_category,
         product_detail;
