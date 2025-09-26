# SQL-Global-CO2-Emissions

# 🌍 SQL Project: Tracking Carbon Emissions by Industry

## 📌 Overview
Understanding carbon emissions across various industries is vital in tackling global climate change.  
With SQL, data analysts can uncover **which sectors are the biggest polluters** and **track how these emissions change over time** to support data-driven sustainability decisions.  

This project uses SQL to explore emissions data by **industry, country, and year**, helping answer key questions such as:
- Which industry had the highest CO2 emissions in the most recent year?
- What has been the trend of total emissions across sectors over the last decade?
- Which industries showed a decline in emissions over the years?
- How does the emission share differ across continents or economic zones?
- Who are the top three emitting industries, and what are their year-wise patterns?

---

## 📂 Dataset
- **Source:** [Carbon Emissions by Sector Dataset on Kaggle](https://www.kaggle.com/)  
- **Contents:**
  - Industry-level emissions data  
  - Country and continent identifiers  
  - Yearly emissions by greenhouse gas type (CO2, CH4, N2O, etc.)  

---

## 🛠️ Project Workflow
1. **Database Setup**
   - Import the Kaggle dataset into a relational database (SQL Server / MySQL / PostgreSQL).
   - Create tables for industries, countries, years, and emission values.
   - Clean data to handle missing or non-numeric values.

2. **Exploratory Queries**
   - `GROUP BY` → Summarize emissions by industry, continent, or year.  
   - `ORDER BY` → Rank industries from highest to lowest emissions.  
   - `HAVING` → Filter for industries with increasing or decreasing trends.  

3. **Key SQL Queries**
   - **Highest CO2-emitting industry in the most recent year**
     ```sql
     SELECT Industry, SUM(CAST(CO2 AS FLOAT)) AS TotalCO2
     FROM CarbonEmissions
     WHERE Year = (SELECT MAX(Year) FROM CarbonEmissions)
     GROUP BY Industry
     ORDER BY TotalCO2 DESC;
     ```
   - **Trend of emissions across sectors (last 10 years)**
     ```sql
     SELECT Industry, Year, SUM(CAST(TotalEmissions AS FLOAT)) AS YearlyEmissions
     FROM CarbonEmissions
     WHERE Year >= YEAR(GETDATE()) - 10
     GROUP BY Industry, Year
     ORDER BY Industry, Year;
     ```
   - **Industries with declining emissions**
     ```sql
     SELECT Industry
     FROM (
         SELECT Industry, Year, SUM(CAST(TotalEmissions AS FLOAT)) AS Emissions,
                LAG(SUM(CAST(TotalEmissions AS FLOAT))) OVER (PARTITION BY Industry ORDER BY Year) AS PrevYear
         FROM CarbonEmissions
         GROUP BY Industry, Year
     ) t
     WHERE Emissions < PrevYear;
     ```
   - **Emission share across continents**
     ```sql
     SELECT Continent, SUM(CAST(TotalEmissions AS FLOAT)) AS Emissions
     FROM CarbonEmissions
     GROUP BY Continent
     ORDER BY Emissions DESC;
     ```
   - **Top 3 industries with year-wise patterns**
     ```sql
     SELECT Industry, Year, SUM(CAST(TotalEmissions AS FLOAT)) AS Emissions
     FROM CarbonEmissions
     WHERE Industry IN (
         SELECT TOP 3 Industry
         FROM CarbonEmissions
         WHERE Year = (SELECT MAX(Year) FROM CarbonEmissions)
         GROUP BY Industry
         ORDER BY SUM(CAST(TotalEmissions AS FLOAT)) DESC
     )
     GROUP BY Industry, Year
     ORDER BY Industry, Year;
     ```

---

## 📊 Insights You Can Generate
- Identify **global leaders in emissions** by industry.  
- Detect **declining vs. growing sectors** in terms of emissions.  
- Compare **regional emission contributions**.  
- Highlight industries showing **sustainable progress**.  

---

## 🚀 Future Improvements
- Integrate visualization tools like **Power BI** or **Tableau** for dashboards.  
- Add machine learning forecasts for emission trends.  
- Expand to real-time monitoring with APIs.  

---

## 🤝 Contributions
Pull requests and suggestions are welcome!  
If you’d like to contribute, fork the repo and open a PR with your improvements.  

---

## 📜 License
This project is licensed under the MIT License.  

---
