IF OBJECT_ID('gold.dem_customers', 'V') IS NOT NULL
    DROP VIEW gold.dem_customers;
GO
create view gold.dem_customers as
select
row_number() over(order by ci.cst_id) as customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
ci.cst_marital_status as marital_status,
case when ci.cst_gndr != 'N/A' then ci.cst_gndr
else coalesce(ca.gen,'N/A') 
end as gender,
lo.cntry as country,
ca.bdate as birthday,
cst_create_date as create_date
from silver.crm_cust_info ci left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid left join silver.erp_loc_a101 lo
on ci.cst_key = lo.cid
go
IF OBJECT_ID('gold.dem_products', 'V') IS NOT NULL
    DROP VIEW gold.dem_products;
GO
create view gold.dem_products as
select 
row_number() over(order by prd_id) as product_key,
pe.prd_id as product_id,
pe.prd_key as product_number,
pe.prd_nm as product_name,
pe.cat_id as category_id,
pc.cat as category,
pc.subcat as subcategory,
pc.maintenance as maintenance,
pe.prd_cost as cost,
pe.prd_line as product_line,
pe.prd_start_dt as start_date
from silver.crm_prd_info pe left join silver.erp_px_cat_g1v2 pc
on pe.cat_id = pc.id
where pe.prd_end_dt is null
go
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
create view gold.fact_sales as
select 
sd.sls_ord_num as order_name,
gc.customer_key ,
gp.product_key ,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as ship_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales_amount,
sd.sls_quantity as quantity,
sd.sls_price as price
from silver.crm_sales_details sd left join gold.dem_customers gc
on sd.sls_cust_id= gc.customer_id left join gold.dem_products gp
on sd.sls_prd_key = gp.product_number
go
