# ⛽📊 India Fuel Sales Analytics (2019-2024) | SQL + PostgreSQL

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

## ⚙️ Approach

**Database:** PostgreSQL with optimized schema, CSV batch loading (36+ states)

**Analysis:** Data quality checks, descriptive analytics, YoY growth rates, COVID-19 impact assessment, 4-tier market segmentation (NTILE), 5-year CAGR forecasting

**SQL Techniques:** CTEs, Window Functions, UNION ALL, CASE statements, Mathematical functions

**Power BI:** Interactive dashboard with 8+ visualizations, regional filters, drill-downs, KPI cards, trend analysis

---

## 🔍 Key SQL Analysis (15 Queries)

### Basic (2)
1. Null analysis & data validation
2. Data preview & structure check

### Medium (5)
3. State-wise 5-year fuel totals
4. Top consuming states (2023-24)
5. Lowest consuming states (2023-24)
6. Petrol vs diesel ratio (2023-24)
7. Year-wise national sales trends

### Advanced (6)
8. YoY growth by state
9. Continuous diesel growth states
10. Top 5 states' market share (%)
11. COVID-19 impact on diesel sales
12. Petrol overtaking diesel analysis
13. 5-year average consumption

### Expert (2)
14. 4-tier market segmentation (NTILE)
15. CAGR forecasting & investment recommendations (AI-assisted):
    - 5-year CAGR (petrol, diesel, total)
    - 2024-25 predictions
    - Growth categories & investment priorities
    - Fuel preference outlook
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

## 📊 Power BI Dashboard

### Dashboard Overview
Created an interactive Power BI dashboard with comprehensive visualizations and dynamic filtering capabilities for deep-dive analysis.

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

## 🧰 Technologies Used

- **Database:** PostgreSQL
- **Language:** SQL
- **Visualization:** Power BI
- **Key Techniques:** CTEs, Window Functions, UNION, CASE Statements, Aggregate Functions, CAGR Calculations, DAX Measures


