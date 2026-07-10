/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For Patients segmentation and analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment patients into age ranges and 
count how many patients fall into each segment*/
WITH patients_segments AS (
    SELECT
        patient_id,
        Age,
    CASE WHEN Age < 5 THEN 'under 5'
		 WHEN Age BETWEEN 5 AND 9 THEN '5 - 9'
		 WHEN Age BETWEEN 10 AND 14 THEN '10 - 14'
		 WHEN Age BETWEEN 15 AND 17 THEN '15 - 17'
		 WHEN Age BETWEEN 18 AND 19 THEN '18 - 19'
		 WHEN Age BETWEEN 20 AND 24 THEN '20 - 24'
		 WHEN Age BETWEEN 25 AND 29 THEN '25 - 29'
		 WHEN Age BETWEEN 30 AND 34 THEN '30 - 34'
		 WHEN Age BETWEEN 35 AND 39 THEN '35 - 39'
		 WHEN Age BETWEEN 40 AND 44 THEN '40 - 44'
		 WHEN Age BETWEEN 45 AND 49 THEN '45 - 49'
		 WHEN Age BETWEEN 50 AND 54 THEN '50 - 54'
		 WHEN Age BETWEEN 55 AND 59 THEN '55 - 59'
		 WHEN Age BETWEEN 60 AND 64 THEN '60 - 64'
		 WHEN Age BETWEEN 65 AND 70 THEN '65 - 70'
		 WHEN Age >=70 THEN '>=70'
	ELSE 'unknown'
	END AS age_range
    FROM gold.dim_patients
)
SELECT 
    age_range,
    COUNT(patient_id) AS total_patients
FROM patients_segments
GROUP BY age_range
ORDER BY total_patients DESC;

/*Segment patients into Length of stay and 
count how many patients fall into each segment*/
WITH patients_segments AS (
    SELECT
        patient_id,
        length_of_stay,
	CASE WHEN length_of_stay BETWEEN 0 AND 2 THEN 'Short stay'
		 WHEN length_of_stay BETWEEN 3 AND 7 THEN 'Typical stay'
		 WHEN length_of_stay BETWEEN 8 AND 14 THEN 'Long stay'
	ELSE 'Extended stay'
	END AS stay_segment
    FROM gold.dim_patients
)
SELECT 
    stay_segment,
    COUNT(patient_id) AS total_patients
FROM patients_segments
GROUP BY stay_segment
ORDER BY total_patients DESC;

/*Segment patients into Bill paid and 
count how many patients fall into each segment*/
WITH patients_segments AS (
    SELECT
        patient_id,
        Total_bill,
	CASE WHEN Total_bill BETWEEN 0 AND 5000 THEN 'Low cost'
		 WHEN Total_bill BETWEEN 5001 AND 20000 THEN 'Medium cost'
		 WHEN Total_bill BETWEEN 20001 AND 100000 THEN 'High cost'
		 WHEN Total_bill BETWEEN 100001 AND 500000 THEN 'Very high cost'
	ELSE 'Extreme outlier'
	END AS pay_segment
    FROM gold.fact_bills
)
SELECT 
    pay_segment,
    COUNT(patient_id) AS total_patients
FROM patients_segments
GROUP BY pay_segment
ORDER BY total_patients DESC;




