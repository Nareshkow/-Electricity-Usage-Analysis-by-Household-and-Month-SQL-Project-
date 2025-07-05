# ⚡Electricity Usage Analysis by Household and Month (SQL Project)

## Project Objective
The main objective of this project is to analyze electricity usage data for different households on a monthly basis, understand their consumption patterns, classify them based on usage and billing, and implement automated calculations using SQL advanced concepts like CASE statements, ranking, pivoting, procedures, triggers

## Key Goals Include

● Classify households based on usage and cost for better billing and insights.

● Automate payment status and cost calculations using SQL logic.

● Analyze monthly trends, ranks, and seasonal usage patterns.

● Integrate regional and environmental data for deeper analysis.

● Use advanced SQL (procedures, triggers, pivots) to automate reports and reduce manual work.

## Dataset and Tables Used
 
1.Billing Information : Core data on each household’s electricity usage, cost, billing status.

2.Household Information: Additional household info 

3.Appliance Usage: Appliance usage data 

4. Environmental Data : Environmental data like outdoor temperature.

5.Calculated Metrics: Table to store calculated metrics.

## Task 1: Update Payment Status Based on Cost

Goal: Categorize each household’s payment status using their cost in USD.

Logic:
Cost > 200 → "High"
Cost > 100 & ≤ 200 → "Medium"
Else → "Low"

## Task 2: Monthly Usage Analysis with Ranking

Goal:Find monthly electricity usage for each household.

Rank them within each year.
Classify as "High" or "Low" usage.
Logic:If total kWh > 500 → "High".
Else → "Low".

## Task 3: Create Monthly Pivot Table

Goal:Show each household’s usage in Jan, Feb, and Mar as separate columns.

How:Used conditional aggregation (pivot logic with CASE).

## Task 4: Average Monthly Usage per Household with City

Goal:Show each household’s average usage per month and display their city.

How:Joined billing_info with hh_info, used AVG and GROUP BY.

## Task 5: High AC Usage Analysis

Goal:Find households with AC usage > 100 kWh and check their outdoor temperature.

How:Joined app_usage and env_data, used a subquery to filter high AC usage.

## Task 6: Procedure to Retrieve Billing Info by Region

Goal:Create a procedure that returns all billing info for a given region.

How:Created stored procedure with IN parameter.

## Task 7: Procedure to Calculate Total Usage for Household

Goal:Calculate total kWh usage for a specific household and return it via an INOUT parameter.

How:Used SELECT INTO and procedure logic.

## Task 8: BEFORE INSERT Trigger for Auto Cost Calculation

Goal:Automatically set cost_usd when new billing data is inserted.

How:Created BEFORE INSERT trigger to calculate:
cost_usd = total_kwh * rate_per_kwh.















