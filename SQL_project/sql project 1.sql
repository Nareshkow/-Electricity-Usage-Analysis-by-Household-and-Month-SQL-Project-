create database eletric;
use eletric;
select * from appliance_usage;
select * from billing_info;
select * from environmental_data;
select * from household_info;
select * from calculated_metrics;

-- Project Task 1: Update the payment_status in the billing_info table based on the cost_usd value. Use CASE...END logic. -- 
-- Hint Cost_usd > 200 set “high” Cost_usd >  100 and 200  set “medium” Else “Low” -- 


update billing_info set payment_status = 
case
when cost_usd > 200 then 'high'
when cost_usd > 100 then 'medium'
else 'low'
end;
select * from billing_info where payment_status="high";

/* Project Task 2: (Using Group by) For each household, show the monthly electricity usage, rank of usage within each year, and classify usage level.
•	Hint: Use SUM, MONTHNAME, Date_format, RANK() OVER, and CASE.
•	Hint2: update Usage level criteria using total Kwh
Sum(total kwh > 500 then “High”
Else “Low” */

select household_id, total_kwh, year, month,
round(sum(total_kwh)) as total_usage, rank() over(order by total_kwh desc) as usage_rank,
case when round(sum(total_kwh)) > 500 then 'High'
else 'Low'
end
as usage_level from billing_info 
group by household_id, year, month,total_kwh
order by household_id;




/* Project Task 3:
Create a monthly usage pivot table showing usage for January, February, and March.
•	Hint: Use conditional aggregation using Pivot concept with CASE WHEN. */

 
 select household_id,
round(sum(case when `month` = 'jan' then total_kwh else 0 end) ,1) as January_Usage,
round(sum(case when `month` = 'feb' then total_kwh else 0 end),1) as February_Usage,
round(sum(case when `month` = 'feb' then total_kwh else 0 end),1) as March_Usage
from
  billing_info where `month`in("jan","feb","mar")
group by 
  household_id;
 
 -- 4.Project Task 4: Show average monthly usage per household with city name.
   -- 	Hint: Use a subquery grouped by household and month -- 

  
  select B.*,H.city from billing_info B inner join household_info H on B.household_id=H.household_id where
total_kwh in (select round(avg(total_kwh),2) from billing_info 
group by household_id, month);


-- Project Task 5: Retrieve AC usage and outdoor temperature for households where AC usage is high -- 
-- Hint: Use a subquery to filter AC usage above 100.(High) -- 


select A.household_id,A.kwh_usage_AC,  E.avg_outdoor_temp from appliance_usage A inner join environmental_data E on A.household_id = E.household_id
where kwh_usage_AC in(select kwh_usage_AC from appliance_usage where kwh_usage_AC >100);

-- Project Task 6: Create a procedure to return billing info for a given region-- 
-- 	Hint: Use IN parameter in a CREATE PROCEDURE-- 

create table naresh as select B.*,H.region from billing_info B inner join household_info H on B.household_id = H.household_id;

delimiter //
create procedure reg(in region_name varchar(40))
begin
select * from naresh where region = region_name;
end // 
delimiter ;

call reg('east');
select *from naresh;


/* Project Task 7: Create a procedure to calculate total usage for a household and return it.
	Hint: Use INOUT parameter and assign with SELECT INTO. */

DELIMITER //

CREATE TRIGGER before_insert_billing
BEFORE INSERT ON billing_info
FOR EACH ROW
BEGIN
  SET NEW.cost_usd = NEW.total_kwh * NEW.rate_per_kwh;
END //

DELIMITER ;

select * from billing_info;


/* Project Task 7: Create a procedure to calculate total usage for a household and return it.
	Hint: Use INOUT parameter and assign with SELECT INTO. */

select * from billing_info;
delimiter !!
create procedure sum_usage(in inp_hh_id varchar(50), inout final_usage double)
begin
select round(sum(total_kwh)) into final_usage from billing_info where household_id=inp_hh_id;
end !!
delimiter ;
set @final_usage= 0;
call sum_usage('H0007', @final_usage);
select @final_usage as total_usage_for_household;



/*Project Task 8: Automatically calculate cost_usd before inserting into billing_info.
 Hint: Use BEFORE INSERT trigger and assign NEW.cost_usd.*/


delimiter !!
create trigger cost_usd_update before insert on billing_info for each row 
begin 
set new.cost_usd=new.total_kwh * new.rate_per_kwh;
end !!
delimiter ;
show triggers;

insert into billing_info(household_id, rate_per_kwh, total_kwh) values ('H5001', 0.18, 1900);
select * from billing_info;

drop trigger cost_usd_update;
select household_id, rate_per_kwh, cost_usd, total_kwh from billing_info order by household_id desc;
select * from billing_info;
select * from billing_info where household_id='H5001';
delete from billing_info where household_id='H5001';


