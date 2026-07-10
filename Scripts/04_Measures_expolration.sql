/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the total number of patients
SELECT COUNT(patient_id) AS total_customers FROM gold.dim_patients;

-- Find the Total bill amount
SELECT SUM(total_bill) AS total_sales FROM gold.fact_bills

-- Find the Total patients bill
SELECT SUM(patient_bill) AS total_sales FROM gold.fact_bills

-- Find the Total insurance bill
SELECT SUM(insurance_bill) AS total_sales FROM gold.fact_bills

-- Find the average total bill
SELECT AVG(total_bill) AS avg_price FROM gold.fact_bills

-- Find the average patient bill
SELECT AVG(patient_bill) AS avg_price FROM gold.fact_bills

-- Find the average insurance bill
SELECT AVG(insurance_bill) AS avg_price FROM gold.fact_bills

-- Generate a Report that shows all key metrics of the Hospital

SELECT 'total_customers' AS measure_name, COUNT(patient_id) AS total_customers FROM gold.dim_patients
UNION ALL
SELECT 'total_bill', SUM(total_bill) FROM gold.fact_bills
UNION ALL
SELECT 'total_by_patient', SUM(patient_bill) FROM gold.fact_bills
UNION ALL
SELECT 'Total_by_insurance', SUM(insurance_bill) FROM gold.fact_bills
UNION ALL
SELECT 'total_average', AVG(total_bill) FROM gold.fact_bills
UNION ALL
SELECT 'patient_bill_average', AVG(patient_bill) FROM gold.fact_bills
UNION ALL
SELECT 'insurance_bill_average', AVG(insurance_bill) FROM gold.fact_bills
