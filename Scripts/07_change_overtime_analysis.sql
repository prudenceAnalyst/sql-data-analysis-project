/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse Patients and Bills over time
-- Quick Date Functions
SELECT
    YEAR(Registration_date) AS registration_year,
    MONTH(Registration_date) AS Registration_date,
	COUNT(DISTINCT Patient_id) AS total_patients,
    SUM(Total_bill) AS total_bill,
    SUM(Patient_bill) AS patient_bill,
	SUM(insurance_bill) AS insurance_bill
FROM gold.fact_bills
WHERE Registration_date IS NOT NULL
GROUP BY YEAR(Registration_date), MONTH(Registration_date)
ORDER BY YEAR(Registration_date), MONTH(Registration_date);

-- DATETRUNC()
SELECT
    DATETRUNC(month, Registration_date) AS Registration_date,
    COUNT(DISTINCT Patient_id) AS total_patients,
    SUM(Total_bill) AS total_bill,
    SUM(Patient_bill) AS patient_bill,
	SUM(insurance_bill) AS insurance_bill
FROM gold.fact_bills
WHERE Registration_date IS NOT NULL
GROUP BY DATETRUNC(month, Registration_date)
ORDER BY DATETRUNC(month, Registration_date);

-- FORMAT()
SELECT
    FORMAT(Registration_date, 'yyyy-MMM') AS Registration_date,
    COUNT(DISTINCT Patient_id) AS total_patients,
    SUM(Total_bill) AS total_bill,
    SUM(Patient_bill) AS patient_bill,
	SUM(insurance_bill) AS insurance_bill
FROM gold.fact_bills
WHERE Registration_date IS NOT NULL
GROUP BY FORMAT(Registration_date, 'yyyy-MMM')
ORDER BY FORMAT(Registration_date, 'yyyy-MMM');
