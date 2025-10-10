/*
project:  india fuel sales analytics (2019-2024)
database: india_fuel_analytics (postgresql)
author:   farhan khan
purpose:  analysis of petrol and diesel consumption across indian states over 5 years,
          including descriptive analytics, market segmentation, cagr forecasting, and investment recommendations.
source data: csv (fuel_data_2019-24.csv)
*/

-- creating table 

create table fuel_sales(
    sr_no integer primary key,
    state_ut varchar(100) not null,  
-- 2019-20 data
    petrol_2019_20 numeric(10,2),  
    diesel_2019_20 numeric(10,2),  
-- 2020-21 data
    petrol_2020_21 numeric(10,2),
    diesel_2020_21 numeric(10,2),   
-- 2021-22 data
    petrol_2021_22 numeric(10,2),
    diesel_2021_22 numeric(10,2),  
-- 2022-23 data
    petrol_2022_23 numeric(10,2),
    diesel_2022_23 numeric(10,2), 
-- 2023-24 data
    petrol_2023_24 numeric(10,2),
    diesel_2023_24 numeric(10,2)
);

-- importing the data in table 
copy fuel_sales(
	sr_no,state_ut,
	petrol_2019_20,diesel_2019_20,
	petrol_2020_21,diesel_2020_21,
	petrol_2021_22,diesel_2021_22,
	petrol_2022_23,diesel_2022_23,
	petrol_2023_24,diesel_2023_24)
from 'c:\sql\fuel_data(2019-24).csv'
with (format csv,header true);

select * from fuel_sales;

-- complete null analysis for all columns
select 
    count(*) as total_rows,
    count(*) - count(petrol_2019_20) as petrol_2019_nulls,
    count(*) - count(diesel_2019_20) as diesel_2019_nulls,
    count(*) - count(petrol_2020_21) as petrol_2020_nulls,
    count(*) - count(diesel_2020_21) as diesel_2020_nulls,
    count(*) - count(petrol_2021_22) as petrol_2021_nulls,
    count(*) - count(diesel_2021_22) as diesel_2021_nulls,
    count(*) - count(petrol_2022_23) as petrol_2022_nulls,
    count(*) - count(diesel_2022_23) as diesel_2022_nulls,
    count(*) - count(petrol_2023_24) as petrol_2023_nulls,
    count(*) - count(diesel_2023_24) as diesel_2023_nulls
from fuel_sales;

-- viewing table 
select * from fuel_sales
limit 10;


--## medium data analysis questions 

-- total petrol & diesel sales by state (all years)
select
state_ut,
(petrol_2019_20 + petrol_2020_21 + petrol_2021_22 + petrol_2022_23 + petrol_2023_24) as total_petrol_consumptions,
(diesel_2019_20 + diesel_2020_21 + diesel_2021_22 + diesel_2022_23 + diesel_2023_24) as total_diesel_consumptions
from fuel_sales
order by total_petrol_consumptions desc , total_diesel_consumptions desc;

-- state with the highest petrol and diesel consumption in 2023-24
(select 'petrol' as fuel_type, state_ut, petrol_2023_24 as consumption
from fuel_sales
order by petrol_2023_24 desc
limit 1)
union all
(select 'diesel' as fuel_type, state_ut, diesel_2023_24 as consumption
from fuel_sales
order by diesel_2023_24 desc
limit 1);


-- state with the lowest petrol and diesel consumption in 2023-24
(select 'petrol' as fuel_type, state_ut, petrol_2023_24 as consumption
from fuel_sales
order by petrol_2023_24 asc
limit 1)
union all
(select 'diesel' as fuel_type, state_ut, diesel_2023_24 as consumption
from fuel_sales
order by diesel_2023_24 asc
limit 1);


-- petrol vs diesel ratio for each state (latest year 2023-24)
select
state_ut,
petrol_2023_24,
diesel_2023_24,
round(petrol_2023_24/diesel_2023_24,3) as petrol_diesel_ratio
from fuel_sales
order by petrol_diesel_ratio desc;


-- year-wise total petrol & diesel sales across india
select 
	'2019-20' as year,
	sum(petrol_2019_20) as total_petrol,
	sum(diesel_2019_20) as total_diesel
	from fuel_sales
union all 
	select 
	'2020-21' as year,
	sum(petrol_2020_21),
	sum(diesel_2020_21)
	from fuel_sales
union all
	select
	'2021-22' as year,
	sum(petrol_2021_22),
	sum(diesel_2021_22)
	from fuel_sales
union all
	select
	'2022-23' as year,
	sum(petrol_2022_23),
	sum(diesel_2022_23)
	from fuel_sales
union all
	select
	'2023-24' as year,
	sum(petrol_2023_24),
	sum(diesel_2023_24)
	from fuel_sales;


--## advance data analysis questions

-- yoy growth in petrol sales for each state
select
	state_ut,
	petrol_2019_20,
	petrol_2020_21,
case when petrol_2019_20=0 then null
	else round(((petrol_2020_21-petrol_2019_20)/petrol_2019_20)*100,2) end  as growth_2020_21,
petrol_2021_22,
case when petrol_2020_21 =0 then null
	else round(((petrol_2021_22-petrol_2020_21)/petrol_2020_21)*100,2) end  as growth_2021_22,
petrol_2022_23,
case when petrol_2021_22 = 0 then null
	else round(((petrol_2022_23-petrol_2021_22)/petrol_2021_22)*100,2) end as growth_2022_23,
petrol_2023_24,
case when petrol_2022_23=0 then null
	else round(((petrol_2023_24-petrol_2022_23)/petrol_2022_23)*100,2) end as growth_2023_24
from fuel_sales
order by sr_no;


--states with continuous growth in diesel sales across 5 years
select
state_ut,
diesel_2019_20 , diesel_2020_21, diesel_2021_22, diesel_2022_23, diesel_2023_24
from fuel_sales
where diesel_2023_24 > diesel_2022_23 
and   diesel_2022_23 > diesel_2021_22
and   diesel_2021_22 > diesel_2020_21
and   diesel_2020_21 > diesel_2019_20;

-- top 5 state contributing the highest % of india’s petrol sales (2023-24)
select
state_ut,
petrol_2023_24,
round((petrol_2023_24 / total_sales) * 100, 2) as contribution_pct
from(
	select
	state_ut,
	petrol_2023_24,
	sum(petrol_2023_24) over () as total_sales
	from fuel_sales)t
order by contribution_pct desc
limit 5;

--compare diesel sales drop during covid year (2020-21) vs (2019-2020) , identify biggest decline state.
select
state_ut,
diesel_2019_20,
diesel_2020_21,
(diesel_2019_20 - diesel_2020_21) as drop_amount, -- positive values means declined sales
round(((diesel_2019_20 - diesel_2020_21)/diesel_2019_20)*100,2) as drop_percentage
from fuel_sales
order by drop_amount desc; -- to get biggest decline state.


--find states where petrol sales overtook diesel sales in any year
select *
from fuel_sales
where petrol_2019_20 > diesel_2019_20
or  petrol_2020_21 > diesel_2020_21
or  petrol_2021_22 > diesel_2021_22
or  petrol_2022_23 > diesel_2022_23
or  petrol_2023_24 > diesel_2023_24; 


-- average petrol & diesel consumption (2019-20 to 2023-24) by state
select 
state_ut,
round((petrol_2019_20 + petrol_2020_21 + petrol_2021_22 + petrol_2022_23 + petrol_2023_24)/5,2) as avg_petrol_consumption,
round((diesel_2019_20 + diesel_2020_21 + diesel_2021_22 + diesel_2022_23 + diesel_2023_24)/ 5,2) as avg_diesel_consumption
from fuel_sales
order by avg_petrol_consumption desc , avg_diesel_consumption desc;


--## more advance analysis questions 

-- 1. market segmentation analysis : rank states by 5-year fuel consumption into four tiers with descriptive labels.

with market_tiers as (
select
state_ut,
(petrol_2019_20 + petrol_2020_21 + petrol_2021_22 + petrol_2022_23 + petrol_2023_24 +
diesel_2019_20 + diesel_2020_21 + diesel_2021_22 + diesel_2022_23 + diesel_2023_24) as total_5yr_consumption
from fuel_sales
)
select 
state_ut,
total_5yr_consumption,
5 - ntile(4) over (order by total_5yr_consumption) as market_tier,
case 
     when 5 - ntile(4) over (order by total_5yr_consumption) = 1 then 'very high consumption' 
	 when 5 - ntile(4) over (order by total_5yr_consumption) = 2 then 'high consumption'
	 when 5 - ntile(4) over (order by total_5yr_consumption) = 3 then 'moderate consumption' 
	 else 'low consumption' end as consumption_description
from market_tiers
order by total_5yr_consumption desc;


-- 2. advanced predictive forecasting analysis (5-year cagr) ( using ai assistant)

with cagr_analysis as (
    select 
        state_ut,
        petrol_2019_20,
        petrol_2023_24,
        diesel_2019_20,
        diesel_2023_24,
-- calculate 5-year cagr (compound annual growth rate)
-- cagr formula: (ending value / beginning value)^(1/number of years) - 1
case 
    when petrol_2019_20 = 0 and petrol_2023_24 > 0 then 999.99
    when petrol_2019_20 > 0 then round(power((petrol_2023_24 / petrol_2019_20), 0.25) * 100 - 100, 2)
    else 0
end as petrol_cagr,
case 
    when diesel_2019_20 = 0 and diesel_2023_24 > 0 then 999.99
    when diesel_2019_20 > 0 then round(power((diesel_2023_24 / diesel_2019_20), 0.25) * 100 - 100, 2)
    else 0
end as diesel_cagr,     
-- total fuel cagr
case 
    when (petrol_2019_20 + diesel_2019_20) = 0 then 999.99
    else round(power(((petrol_2023_24 + diesel_2023_24) / nullif((petrol_2019_20 + diesel_2019_20), 0)), 0.25) * 100 - 100, 2)
end as total_fuel_cagr   
    from fuel_sales
),
forecast_predictions as (
    select 
        state_ut,
        petrol_2023_24,
        diesel_2023_24,
        petrol_cagr,
        diesel_cagr,
        total_fuel_cagr,
-- predict 2024-25 consumption using cagr
        case 
            when petrol_cagr = 999.99 then petrol_2023_24 * 1.1
            else round(petrol_2023_24 * power((1 + petrol_cagr/100), 1), 2)
        end as predicted_petrol_2024_25,
        case 
            when diesel_cagr = 999.99 then diesel_2023_24 * 1.1
            else round(diesel_2023_24 * power((1 + diesel_cagr/100), 1), 2)
        end as predicted_diesel_2024_25,
-- calculate absolute increase/decrease
        case 
            when petrol_cagr = 999.99 then round(petrol_2023_24 * 0.1, 2)
            else round(petrol_2023_24 * (power((1 + petrol_cagr/100), 1) - 1), 2)
        end as petrol_change_amount,
        case 
            when diesel_cagr = 999.99 then round(diesel_2023_24 * 0.1, 2)
            else round(diesel_2023_24 * (power((1 + diesel_cagr/100), 1) - 1), 2)
        end as diesel_change_amount   
    from cagr_analysis)
select 
    state_ut,
     -- current consumption (2023-24)
    petrol_2023_24 as current_petrol_sales,
    diesel_2023_24 as current_diesel_sales,
    -- growth rates
    petrol_cagr as petrol_5yr_cagr,
    diesel_cagr as diesel_5yr_cagr,
    total_fuel_cagr,
    -- predictions for 2024-25
    predicted_petrol_2024_25,
    predicted_diesel_2024_25,
    petrol_change_amount,
    diesel_change_amount,
-- business classifications
    case 
        when total_fuel_cagr = 999.99 then 'new market'
        when total_fuel_cagr > 15 then 'explosive growth market'
        when total_fuel_cagr > 10 then 'high growth market'
        when total_fuel_cagr > 5 then 'moderate growth market'
        when total_fuel_cagr > 0 then 'slow growth market'
        else 'declining market'
    end as growth_category,
-- investment recommendations
    case 
        when total_fuel_cagr = 999.99 then 'new market development'
        when (predicted_petrol_2024_25 + predicted_diesel_2024_25) > 5000 and total_fuel_cagr > 8 then 'priority investment'
        when (predicted_petrol_2024_25 + predicted_diesel_2024_25) > 3000 and total_fuel_cagr > 5 then 'consider investment'
        when total_fuel_cagr > 10 then 'high potential market'
        else 'monitor only'
    end as investment_recommendation,
-- market outlook
    case 
        when total_fuel_cagr = 999.99 then 'emerging market'
        when petrol_cagr > diesel_cagr + 5 then 'petrol-driven growth'
        when diesel_cagr > petrol_cagr + 5 then 'diesel-driven growth'
        else 'balanced growth'
    end as fuel_preference_outlook 
from forecast_predictions
order by (predicted_petrol_2024_25 + predicted_diesel_2024_25) desc;
