/*
===============================================================================
patients Report
===============================================================================
Purpose:
    - This report consolidates key patients metrics and behaviors

Highlights:
    1. Gathers essential fields such as patient_id, Registration_date, gender, Age, etc,...
	2. Segments Patients into categories (stay_segment, pay_segment).
    3. Aggregates customer-level metrics:
	   - total patients
	   - total bill
	   - length of stay
===============================================================================
*/

-- =============================================================================
-- Create Report: gold.report_patients
-- =============================================================================

IF OBJECT_ID('gold.report_patients') IS NOT NULL
    DROP VIEW gold.report_patients;
GO

CREATE VIEW gold.report_patients AS
SELECT 
p.patient_id,
p.Registration_date,
p.Gender,
p.Age,
p.age_range,
p.Adress,
b.Total_bill,
p.Diagnosis,
b.Insurance_provider,
b.payment_status,
b.Satisfaction,
CASE WHEN length_of_stay BETWEEN 0 AND 2 THEN 'Short stay'
	 WHEN length_of_stay BETWEEN 3 AND 7 THEN 'Typical stay'
	 WHEN length_of_stay BETWEEN 8 AND 14 THEN 'Long stay'
	 ELSE 'Extended stay'
END AS stay_segment,
CASE WHEN Total_bill BETWEEN 0 AND 5000 THEN 'Low cost'
	 WHEN Total_bill BETWEEN 5001 AND 20000 THEN 'Medium cost'
	 WHEN Total_bill BETWEEN 20001 AND 100000 THEN 'High cost'
	 WHEN Total_bill BETWEEN 100001 AND 500000 THEN 'Very high cost'
	 ELSE 'Extreme outlier'
END AS pay_segment
FROM gold.dim_patients p
LEFT JOIN gold.fact_bills b
ON p.patient_id = b.Patient_id
WHERE Insurance_provider IS NOT NULL
