/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/
-- Calculate the total bill per month 
-- and the running total of bill over time 
SELECT
	Registration_date,
	Total_bill,
	SUM(Total_bill) OVER (ORDER BY Registration_date) AS running_total_bill,
	AVG(Total_bill) OVER (ORDER BY Registration_date) AS moving_average_bill
FROM
(
    SELECT 
        DATETRUNC(MONTH, Registration_date) AS Registration_date,
        COUNT(DISTINCT Patient_id) AS total_patients,
		SUM(Total_bill) AS total_bill,
		SUM(Patient_bill) AS patient_bill,
		SUM(insurance_bill) AS insurance_bill
    FROM gold.fact_bills
    WHERE Registration_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, Registration_date)
) t
