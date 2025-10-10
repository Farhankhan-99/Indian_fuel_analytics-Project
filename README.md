# India Fuel Sales Analytics (2019-2024) | SQL + PostgreSQL

**🧑‍💻 Author:** Farhan Khan  
**🔗 LinkedIn:** [Connect with me](https://www.linkedin.com/in/farhankhan999/)
**📧 Email:** [farhanriyaz9005@gmail.com](mailto:farhanriyaz9005@gmail.com)


---

## 🏢 Business Problem
Analyze 5 years of state-wise fuel consumption data across India to identify growth patterns, assess COVID-19 impact, and provide data-driven recommendations for market expansion and investment opportunities.

---

## Dataset Overview

**📦 Source:** RAJYA SABHA SESSION - 267, UNSTARRED QUESTION No 772 (Answered: 10 Feb 2025)  
**🏛️ Provider:** Petroleum Planning and Analysis Cell (PPAC)  
**🌐 Link:** [data.gov.in](https://data.gov.in)

**Coverage:**
- Time Period: FY 2019-20 to FY 2023-24 (5 years)
- Geographic Scope: 36+ States and Union Territories
- Fuel Types: Petrol (MS - Motor Spirit) and Diesel (HSD - High-Speed Diesel)
- Unit: Thousand Metric Tonnes (TMT)

**📋 Columns:**
- `sr_no` - Serial number (Primary Key)
- `state_ut` - State/Union Territory name
- `petrol_2019_20`, `diesel_2019_20` - FY 2019-20 sales in TMT
- `petrol_2020_21`, `diesel_2020_21` - FY 2020-21 sales in TMT
- `petrol_2021_22`, `diesel_2021_22` - FY 2021-22 sales in TMT
- `petrol_2022_23`, `diesel_2022_23` - FY 2022-23 sales in TMT
- `petrol_2023_24`, `diesel_2023_24` - FY 2023-24 sales in TMT

---

##⚙️ Approach

**Database Design:**
- Created normalized PostgreSQL database `india_fuel_analytics`
- Designed `fuel_sales` table with proper data types and constraints
- Imported 36+ state records using CSV batch loading

**Analysis Methodology:**
- **Data Quality Check:** Performed complete null analysis across all columns
- **Descriptive Analytics:** Calculated state-wise and year-wise fuel consumption totals
- **Comparative Analysis:** Identified highest/lowest consuming states and petrol-diesel ratios
- **Growth Analytics:** Computed Year-over-Year (YoY) growth rates for trend identification
- **Impact Assessment:** Analyzed COVID-19 effect on diesel sales (2020-21 vs 2019-20)
- **Segmentation:** Ranked states into 4-tier consumption categories using NTILE window function
- **Predictive Modeling:** Calculated 5-year CAGR and forecasted 2024-25 consumption

**Visualization & Reporting:**
- Built interactive Power BI dashboard with 8+ visualizations
- Implemented regional filtering (East, North, South, West zones)
- Created dynamic state-level drill-down capabilities
- Designed KPI cards for key metrics monitoring
- Developed trend analysis with line charts showing COVID impact
- Built comparative bar charts for top/bottom performing states
- Added donut charts for fuel composition and market contribution analysis

**SQL Techniques Used:**
- Common Table Expressions (CTEs) for complex queries
- Window Functions (NTILE, SUM OVER) for ranking and aggregation
- UNION ALL for combining multi-year data
- CASE statements for conditional logic and categorization
- Mathematical functions (POWER, ROUND) for CAGR calculations

---

##❓ Key Analysis Questions

### Basic Analysis (2 queries)
1. Complete null analysis for data quality assessment
2. Data preview and structure validation

### Medium-Level Analysis (5 queries)
3. Total petrol & diesel sales by state (5-year cumulative)
4. Highest consuming states in 2023-24 (petrol & diesel)
5. Lowest consuming states in 2023-24 (petrol & diesel)
6. Petrol vs diesel ratio analysis (2023-24)
7. Year-wise total fuel sales across India

### Advanced Analysis (6 queries)
8. Year-over-Year growth in petrol sales by state
9. States with continuous diesel growth across all 5 years
10. Top 5 states contributing to India's petrol sales (% share)
11. Diesel sales drop during COVID-19 pandemic (state-wise impact)
12. States where petrol sales overtook diesel in any year
13. Average petrol & diesel consumption by state (5-year mean)

### Expert-Level Analysis (2 queries)
14. Market segmentation analysis (4-tier classification)
15. Advanced predictive forecasting with CAGR methodology:
    - 5-year CAGR calculation for petrol, diesel, and total fuel
    - Predicted consumption for 2024-25
    - Growth category classification (Explosive/High/Moderate/Slow/Declining)
    - Investment recommendations (Priority/Consider/High Potential/Monitor)
    - Fuel preference outlook (Petrol-Driven/Diesel-Driven/Balanced)

---

## 🔍 Key Findings

**📊 National Overview (2019-2024):**
- Total 5-year petrol consumption: **160.98K TMT**
- Total 5-year diesel consumption: **407.16K TMT**
- Total fuel consumption: **568.14K TMT**
- Overall YoY growth rate: **4.96%**
- Post-COVID recovery: **112.8%** (2023-24 vs 2020-21)

**🏆 Market Leaders:**
- **Top 5 consuming states:** Uttar Pradesh, Maharashtra, Karnataka, Tamil Nadu, Gujarat
- Top 5 states contribute **46.1%** of India's total fuel consumption
- Remaining states account for **53.9%**

**📉 Lowest Consumption States:**
- **Bottom 5:** Nagaland, Mizoram, Sikkim, Ladakh, Lakshadweep
- These states and union territory represent lowest fuel consumptions.

**⛽ Fuel Preference Analysis:**
- Diesel dominates with **71.67%** of total fuel consumption
- Petrol accounts for **28.33%** of consumption
- Indicates heavy reliance on commercial/freight transportation

**📈 COVID-19 Impact & Recovery:**
- 2020-21 showed significant decline to **101K TMT** (lowest point)
- Strong V-shaped recovery observed from 2021-22 onwards
- 2023-24 reached **127K TMT**, highest in 5 years
- Recovery exceeded pre-COVID levels by **12.8%**

**🚀 Growth Trajectory:**
- **2019-20:** 112K TMT (baseline)
- **2020-21:** 101K TMT (-9.8% COVID impact)
- **2021-22:** 107K TMT (recovery begins)
- **2022-23:** 121K TMT (strong rebound)
- **2023-24:** 127K TMT (peak performance)

---

## Technologies Used

- **Database:** PostgreSQL
- **Language:** SQL
- **Visualization:** Power BI
- **Key Techniques:** CTEs, Window Functions, UNION, CASE Statements, Aggregate Functions, CAGR Calculations, DAX Measures

---

## 📊 Power BI Dashboard

### Dashboard Overview
Created an interactive Power BI dashboard with comprehensive visualizations and dynamic filtering capabilities for deep-dive analysis.

### Key Features
- **Regional Filtering:** East, North, South, West zone selection
- **State-Level Drill-down:** Dropdown filter for 36+ states/UTs
- **Real-time KPIs:** 5 key performance indicators
- **Interactive Charts:** 8+ visualizations with cross-filtering

### Dashboard Components

**KPI Cards (5):**
1. National 5Y Total Petrol: 160.98K TMT
2. National 5Y Total Diesel: 407.16K TMT
3. National 5Y Total Fuel: 568.14K TMT
4. YoY Growth: 4.96%
5. Recovery vs Pre-COVID: 112.8%

**Visualizations:**
1. **Petrol vs Diesel Donut Chart** - Shows fuel type distribution (71.67% Diesel, 28.33% Petrol)
2. **Top 5 States by Fuel Consumption** - Horizontal bar chart highlighting market leaders
3. **Lowest 5 States by Fuel Consumption** - Identifies emerging markets
4. **Top5 vs Rest-India Donut Chart** - Market concentration analysis (46.1% vs 53.9%)
5. **Fuel Consumption Trend (2019-2024)** - Line chart showing COVID impact and recovery pattern

### Insights from Dashboard
- Clear visualization of COVID-19 impact with V-shaped recovery
- Diesel-heavy consumption pattern across India
- Concentration of fuel demand in top 5 states
- Strong post-pandemic growth trajectory

---

## How to Use

### Prerequisites
- PostgreSQL installed
- Basic SQL knowledge

### Setup Steps

1. **Clone repository**
```bash
git clone https://github.com/YOUR_USERNAME/india-fuel-analytics.git
cd india-fuel-analytics
```

2. **Create database**
```sql
CREATE DATABASE india_fuel_analytics;
```

3. **Update CSV path in script**
Modify line in SQL file:
```sql
COPY fuel_sales FROM 'YOUR_PATH/fuel_data(2019-24).csv' 
WITH (FORMAT csv, HEADER true);
```

4. **Run SQL script**
```bash
psql -U username -d india_fuel_analytics -f fuel_analysis.sql
```

5. **Execute queries**
Run individual queries to perform analysis

---

## Project Structure

```
india-fuel-analytics/
│
├── fuel_analysis.sql          # Complete SQL analysis script
├── fuel_data(2019-24).csv     # Source dataset
├── fuel_dashboard.pbix        # Power BI dashboard file
├── README.md                  # Documentation
└── results/                   # Query outputs (optional)
```

---

## 🎯 Future Enhancements

- Machine learning models for demand forecasting
- Integration with fuel price data for price-demand elasticity analysis
- Time-series forecasting using Python (Prophet/ARIMA)
- Correlation analysis with economic indicators (GDP, vehicle sales)
- Real-time data pipeline for monthly updates
- Mobile-responsive dashboard version

---

## Contact

**🧑‍💻 Farhan Khan**  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](www.linkedin.com/in/farhankhan999)

---

⭐ Star this repo if you find it useful!
```
