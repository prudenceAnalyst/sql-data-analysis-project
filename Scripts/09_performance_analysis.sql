/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of Patient, or Bills over time.
    - For benchmarking and identifying high-performing entities.
    - To track monthly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

/* Analyze the monthly performance of Patients by comparing their Bills
to both the average bills performance of patient and the previous month's bill */

WITH monthly_patients_bill AS (
    SELECT
        MONTH (b.Registration_date) AS Registration_month,
        p.patient_id,
        SUM(b.Total_bill) AS current_bill
    FROM gold.fact_bills b
    LEFT JOIN gold.dim_patients p
        ON b.Patient_id = p.patient_id
    WHERE b.Registration_date IS NOT NULL
    GROUP BY 
        MONTH (b.Registration_date),
        p.patient_id
)
SELECT
    Registration_month,
    patient_id,
    current_bill,
    AVG(current_bill) OVER () AS avg_bill,
    current_bill - AVG(current_bill) OVER () AS diff_avg,
    CASE 
        WHEN current_bill - AVG(current_bill) OVER () > 0 THEN 'Above Avg'
        WHEN current_bill - AVG(current_bill) OVER () < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
    -- Month-over-Month Analysis
    LAG(current_bill) OVER (ORDER BY Registration_month) AS py_bills,
    current_bill - LAG(current_bill) OVER (ORDER BY Registration_month) AS diff_py,
    CASE 
        WHEN current_bill - LAG(current_bill) OVER (ORDER BY Registration_month) > 0 THEN 'Increase'
        WHEN current_bill - LAG(current_bill) OVER (ORDER BY Registration_month) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS py_change
FROM monthly_patients_bill
ORDER BY patient_id, Registration_month;
