-- DATABASE IS : india_fuel_analytics

-- CREATING TABLE 

CREATE TABLE fuel_sales(
    sr_no INTEGER PRIMARY KEY,
    state_ut VARCHAR(100) NOT NULL,  
-- 2019-20 data
    petrol_2019_20 NUMERIC(10,2),  
    diesel_2019_20 NUMERIC(10,2),  
-- 2020-21 data
    petrol_2020_21 NUMERIC(10,2),
    diesel_2020_21 NUMERIC(10,2),   
-- 2021-22 data
    petrol_2021_22 NUMERIC(10,2),
    diesel_2021_22 NUMERIC(10,2),  
-- 2022-23 data
    petrol_2022_23 NUMERIC(10,2),
    diesel_2022_23 NUMERIC(10,2), 
-- 2023-24 data
    petrol_2023_24 NUMERIC(10,2),
    diesel_2023_24 NUMERIC(10,2)
);

-- importing the data in table 
copy fuel_sales(
	sr_no,state_ut,
	petrol_2019_20,diesel_2019_20,
	petrol_2020_21,diesel_2020_21,
	petrol_2021_22,diesel_2021_22,
	petrol_2022_23,diesel_2022_23,
	petrol_2023_24,diesel_2023_24)
from 'C:\SQL\fuel_data(2019-24).csv'
with (format csv,header true);

select * from fuel_sales;

-- Complete null analysis for all columns
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

--Viewing table 
select * from fuel_sales
limit 10;


--## MEDIUM DATA ANALYSIS QUESTIONS 

-- Total Petrol & Diesel Sales by State (All Years)
select
state_ut,
(petrol_2019_20 + petrol_2020_21 + petrol_2021_22 + petrol_2022_23 + petrol_2023_24) AS total_petrol_consumptions,
(diesel_2019_20 + diesel_2020_21 + diesel_2021_22 + diesel_2022_23 + diesel_2023_24) AS total_diesel_consumptions
from fuel_sales
order by total_petrol_consumptions desc , total_diesel_consumptions desc;

-- State with the Highest petrol and diesel Consumption in 2023-24
(SELECT 'Petrol' AS fuel_type, state_ut, petrol_2023_24 AS consumption
FROM fuel_sales
ORDER BY petrol_2023_24 desc
LIMIT 1)
union all
(SELECT 'Diesel' AS fuel_type, state_ut, diesel_2023_24 AS consumption
FROM fuel_sales
ORDER BY diesel_2023_24 desc
LIMIT 1);


-- State with the Lowest petrol and diesel Consumption in 2023-24
(SELECT 'Petrol' AS fuel_type, state_ut, petrol_2023_24 AS consumption
FROM fuel_sales
ORDER BY petrol_2023_24 ASC
LIMIT 1)
union all
(SELECT 'Diesel' AS fuel_type, state_ut, diesel_2023_24 AS consumption
FROM fuel_sales
ORDER BY diesel_2023_24 ASC
LIMIT 1);


-- Petrol vs Diesel Ratio for Each State (Latest Year 2023-24)
select
state_ut,
petrol_2023_24,
diesel_2023_24,
round(petrol_2023_24/diesel_2023_24,3) as petrol_diesel_Ratio
from fuel_sales
order by petrol_diesel_Ratio desc;


-- Year-wise Total Petrol & Diesel Sales Across India
SELECT 
	'2019-20' as year,
	sum(petrol_2019_20) as total_petrol,
	sum(diesel_2019_20) as total_diesel
	from fuel_sales
UNION ALL 
	SELECT 
	'2020-21' as year,
	sum(petrol_2020_21),
	sum(diesel_2020_21)
	from fuel_sales
UNION ALL
	SELECT
	'2021-22' as year,
	sum(petrol_2021_22),
	sum(diesel_2021_22)
	from fuel_sales
UNION ALL
	SELECT
	'2022-23' as year,
	sum(petrol_2022_23),
	sum(diesel_2022_23)
	from fuel_sales
UNION ALL
	SELECT
	'2023-24' as year,
	sum(petrol_2023_24),
	sum(diesel_2023_24)
	from fuel_sales;


--## ADVANCE DATA ANALYSIS QUESTIONS

-- YoY Growth in Petrol Sales for Each State
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


--States with Continuous Growth in Diesel Sales Across 5 Years
select
state_ut,
diesel_2019_20 , diesel_2020_21, diesel_2021_22, diesel_2022_23, diesel_2023_24
from fuel_sales
where diesel_2023_24 > diesel_2022_23 
AND   diesel_2022_23 > diesel_2021_22
AND   diesel_2021_22 > diesel_2020_21
AND   diesel_2020_21 > diesel_2019_20;

-- top 5 State Contributing the Highest % of India’s Petrol Sales (2023-24)
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

--Compare Diesel Sales Drop During COVID Year (2020-21) vs (2019-2020) , Identify biggest decline state.
select
state_ut,
diesel_2019_20,
diesel_2020_21,
(diesel_2019_20 - diesel_2020_21) as drop_amount, -- positive values means declined sales
round(((diesel_2019_20 - diesel_2020_21)/diesel_2019_20)*100,2) as drop_percentage
from fuel_sales
order by drop_amount desc; -- to get biggest decline state.


--Find States Where Petrol Sales Overtook Diesel Sales in Any Year
select *
from fuel_sales
where petrol_2019_20 > diesel_2019_20
OR  petrol_2020_21 > diesel_2020_21
OR  petrol_2021_22 > diesel_2021_22
OR   petrol_2022_23 > diesel_2022_23
OR  petrol_2023_24 > diesel_2023_24; 


-- Average Petrol & Diesel consumption (2019-20 to 2023-24) by State
select 
state_ut,
round((petrol_2019_20 + petrol_2020_21 + petrol_2021_22 + petrol_2022_23 + petrol_2023_24)/5,2) as avg_petrol_consumption,
round((diesel_2019_20 + diesel_2020_21 + diesel_2021_22 + diesel_2022_23 + diesel_2023_24)/ 5,2) as avg_diesel_consumption
from fuel_sales
order by avg_petrol_consumption desc , avg_diesel_consumption desc;



--## MORE ADVANCE ANALYSIS QUESTIONS 

-- 1. Market Segmentation Analysis : Rank states by 5-year fuel consumption into four tiers with descriptive labels.

WITH market_tiers AS (
SELECT
state_ut,
(petrol_2019_20 + petrol_2020_21 + petrol_2021_22 + petrol_2022_23 + petrol_2023_24 +
diesel_2019_20 + diesel_2020_21 + diesel_2021_22 + diesel_2022_23 + diesel_2023_24) as total_5yr_consumption
from fuel_sales
)
SELECT 
state_ut,
total_5yr_consumption,
5 - NTILE(4) OVER (order by total_5yr_consumption) as market_tier,
case 
     when 5 - NTILE(4) OVER (order by total_5yr_consumption) = 1 then 'Very High Consumption' 
	 when 5 - NTILE(4) OVER (order by total_5yr_consumption) = 2 then 'High Consumption'
	 when 5 - NTILE(4) OVER (order by total_5yr_consumption) = 3 then 'Moderate Consumption' 
	 else 'Low Consumption' end as consumption_description
from market_tiers
order by total_5yr_consumption desc;


-- 2. Advanced Predictive Forecasting Analysis (5-Year CAGR) ( using AI Assistant)

WITH cagr_analysis AS (
    SELECT 
        state_ut,
        petrol_2019_20,
        petrol_2023_24,
        diesel_2019_20,
        diesel_2023_24,
-- Calculate 5-year CAGR (Compound Annual Growth Rate)
-- CAGR Formula: (Ending Value / Beginning Value)^(1/number of years) - 1
CASE 
    WHEN petrol_2019_20 = 0 AND petrol_2023_24 > 0 THEN 999.99
    WHEN petrol_2019_20 > 0 THEN ROUND(POWER((petrol_2023_24 / petrol_2019_20), 0.25) * 100 - 100, 2)
    ELSE 0
END as petrol_cagr,
CASE 
    WHEN diesel_2019_20 = 0 AND diesel_2023_24 > 0 THEN 999.99
    WHEN diesel_2019_20 > 0 THEN ROUND(POWER((diesel_2023_24 / diesel_2019_20), 0.25) * 100 - 100, 2)
    ELSE 0
END as diesel_cagr,     
-- Total fuel CAGR
CASE 
    WHEN (petrol_2019_20 + diesel_2019_20) = 0 THEN 999.99
    ELSE ROUND(POWER(((petrol_2023_24 + diesel_2023_24) / NULLIF((petrol_2019_20 + diesel_2019_20), 0)), 0.25) * 100 - 100, 2)
END as total_fuel_cagr   
    FROM fuel_sales
),
forecast_predictions AS (
    SELECT 
        state_ut,
        petrol_2023_24,
        diesel_2023_24,
        petrol_cagr,
        diesel_cagr,
        total_fuel_cagr,
-- Predict 2024-25 consumption using CAGR
        CASE 
            WHEN petrol_cagr = 999.99 THEN petrol_2023_24 * 1.1
            ELSE ROUND(petrol_2023_24 * POWER((1 + petrol_cagr/100), 1), 2)
        END as predicted_petrol_2024_25,
        CASE 
            WHEN diesel_cagr = 999.99 THEN diesel_2023_24 * 1.1
            ELSE ROUND(diesel_2023_24 * POWER((1 + diesel_cagr/100), 1), 2)
        END as predicted_diesel_2024_25,
-- Calculate absolute increase/decrease
        CASE 
            WHEN petrol_cagr = 999.99 THEN ROUND(petrol_2023_24 * 0.1, 2)
            ELSE ROUND(petrol_2023_24 * (POWER((1 + petrol_cagr/100), 1) - 1), 2)
        END as petrol_change_amount,
        CASE 
            WHEN diesel_cagr = 999.99 THEN ROUND(diesel_2023_24 * 0.1, 2)
            ELSE ROUND(diesel_2023_24 * (POWER((1 + diesel_cagr/100), 1) - 1), 2)
        END as diesel_change_amount   
    FROM cagr_analysis)
SELECT 
    state_ut,
     -- Current consumption (2023-24)
    petrol_2023_24 as current_petrol_sales,
    diesel_2023_24 as current_diesel_sales,
    -- Growth rates
    petrol_cagr as petrol_5yr_cagr,
    diesel_cagr as diesel_5yr_cagr,
    total_fuel_cagr,
    -- Predictions for 2024-25
    predicted_petrol_2024_25,
    predicted_diesel_2024_25,
    petrol_change_amount,
    diesel_change_amount,
-- Business classifications
    CASE 
        WHEN total_fuel_cagr = 999.99 THEN 'New Market'
        WHEN total_fuel_cagr > 15 THEN 'Explosive Growth Market'
        WHEN total_fuel_cagr > 10 THEN 'High Growth Market'
        WHEN total_fuel_cagr > 5 THEN 'Moderate Growth Market'
        WHEN total_fuel_cagr > 0 THEN 'Slow Growth Market'
        ELSE 'Declining Market'
    END as growth_category,
-- Investment recommendations
    CASE 
        WHEN total_fuel_cagr = 999.99 THEN 'New Market Development'
        WHEN (predicted_petrol_2024_25 + predicted_diesel_2024_25) > 5000 AND total_fuel_cagr > 8 THEN 'Priority Investment'
        WHEN (predicted_petrol_2024_25 + predicted_diesel_2024_25) > 3000 AND total_fuel_cagr > 5 THEN 'Consider Investment'
        WHEN total_fuel_cagr > 10 THEN 'High Potential Market'
        ELSE 'Monitor Only'
    END as investment_recommendation,
-- Market outlook
    CASE 
        WHEN total_fuel_cagr = 999.99 THEN 'Emerging Market'
        WHEN petrol_cagr > diesel_cagr + 5 THEN 'Petrol-Driven Growth'
        WHEN diesel_cagr > petrol_cagr + 5 THEN 'Diesel-Driven Growth'
        ELSE 'Balanced Growth'
    END as fuel_preference_outlook 
FROM forecast_predictions
ORDER BY (predicted_petrol_2024_25 + predicted_diesel_2024_25) DESC;
