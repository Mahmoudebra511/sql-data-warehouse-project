create or alter  procedure bronze.load_bronze as
begin
declare @start_date datetime , @end_date datetime;
begin try
print '=================================================';
print 'Loading Bronze Layer';
print '=================================================';
print '-------------------------------------------------';
print 'Loading CRM Table';
print '-------------------------------------------------';
set @start_date = getdate();
print '##Truncate table:bronze.crm_cust_info';
truncate table bronze.crm_cust_info;
print'##insert into:bronze.crm_cust_info';
bulk insert bronze.crm_cust_info
from 'D:\مشاريع محمود\DWH_Project\Baraa\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_date = getdate();
print'##Load Duration' + cast(datediff(second,@start_date,@end_date) as nvarchar) + 'second';
print'------------------------'
set @start_date = getdate();
print '##Truncate table:bronze.crm_prd_info';
truncate table bronze.crm_prd_info;
print'##insert into:bronze.crm_prd_info';
bulk insert bronze.crm_prd_info
from 'D:\مشاريع محمود\DWH_Project\Baraa\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
print'##Load Duration' + cast(datediff(second,@start_date,@end_date) as nvarchar) + 'second';
print'------------------------'
set @start_date = getdate();
print '##Truncate table:bronze.crm_sales_details';
truncate table bronze.crm_sales_details;
print'##insert into:bronze.crm_sales_details';
bulk insert bronze.crm_sales_details
from'D:\مشاريع محمود\DWH_Project\Baraa\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
print'##Load Duration' + cast(datediff(second,@start_date,@end_date) as nvarchar) + 'second';
print'------------------------'
print '-------------------------------------------------';
print 'Loading ERP Table';
print '-------------------------------------------------';
set @start_date = getdate();
print '##Truncate table:bronze.erp_cust_az12';
truncate table bronze.erp_cust_az12;
print'##insert into:bronze.erp_cust_az12';
bulk insert bronze.erp_cust_az12
from 'D:\مشاريع محمود\DWH_Project\Baraa\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
print'##Load Duration' + cast(datediff(second,@start_date,@end_date) as nvarchar) + 'second';
print'------------------------'
set @start_date = getdate();
print '##Truncate table:bronze.erp_loc_a101';
truncate table bronze.erp_loc_a101;
print'##insert into:bronze.erp_loc_a101';
bulk insert bronze.erp_loc_a101
from 'D:\مشاريع محمود\DWH_Project\Baraa\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
print'##Load Duration' + cast(datediff(second,@start_date,@end_date) as nvarchar) + 'second';
print'------------------------'
set @start_date = getdate();
print '##Truncate table:bronze.erp_px_cat_g1v2';
truncate table bronze.erp_px_cat_g1v2;
print'##insert into:bronze.crm_cust_info';
bulk insert bronze.erp_px_cat_g1v2
from 'D:\مشاريع محمود\DWH_Project\Baraa\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
print'##Load Duration' + cast(datediff(second,@start_date,@end_date) as nvarchar) + 'second';
print'------------------------'
end try
begin catch
print '=================================';
print 'Error detected during Loading Bronze';
print 'Error Message' + error_message();
print 'Error Message' + cast(error_number() as nvarchar);
print 'Error Message' + cast(error_state() as nvarchar);
print '=================================';
end catch
end
