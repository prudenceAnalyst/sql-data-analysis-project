/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last registration date and the total duration in months
SELECT 
    MIN(registration_date) AS first_visit_date,
    MAX(registration_date) AS last_visit_date,
    DATEDIFF(MONTH, MIN(registration_date), MAX(registration_date)) AS visit_range_months
FROM gold.dim_patients;

-- Find the youngest and oldest customer based on birthdate
SELECT
    MIN(date_of_birth) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(date_of_birth), GETDATE()) AS oldest_age,
    MAX(date_of_birth) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(date_of_birth), GETDATE()) AS youngest_age
FROM gold.fact_bills;
