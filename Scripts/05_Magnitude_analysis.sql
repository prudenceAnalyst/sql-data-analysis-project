/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/

-- Find total patients by gender
SELECT
    Gender,
    COUNT(Gender) AS total_patients
FROM gold.dim_patients
GROUP BY Gender
ORDER BY total_patients DESC;

-- Find total patients by age_range
SELECT
    age_range,
    COUNT(age_range) AS total_patients
FROM gold.dim_patients
GROUP BY age_range
ORDER BY total_patients DESC;

-- Find total patients by address
SELECT
    Adress,
    COUNT(Adress) AS total_patients
FROM gold.dim_patients
GROUP BY Adress
ORDER BY total_patients DESC;

-- Find total patients by Stay_segment
SELECT
    length_of_stay,
    COUNT(length_of_stay) AS total_patients
FROM gold.dim_patients
GROUP BY length_of_stay
ORDER BY total_patients DESC;

-- Find total patients by Diagnosis
SELECT
    Diagnosis,
    COUNT(Diagnosis) AS total_patients
FROM gold.dim_patients
GROUP BY Diagnosis
ORDER BY total_patients DESC;

-- Find total patients by Diagnosis
SELECT
    Registration_date,
    COUNT(patient_id) AS total_patients
FROM gold.dim_patients
GROUP BY Registration_date
ORDER BY total_patients DESC;

-- Find total patients by insurance_provider
SELECT
    insurance_provider,
    COUNT(insurance_provider) AS total_patients
FROM gold.fact_bills
GROUP BY insurance_provider
ORDER BY total_patients DESC;

-- Find total patients by payment status
SELECT
    payment_status,
    COUNT(payment_status) AS total_patients
FROM gold.fact_bills
GROUP BY payment_status
ORDER BY total_patients DESC;

-- Find total patients by patients outcome
SELECT
   patient_outcome,
    COUNT(patient_outcome) AS total_patients
FROM gold.dim_patients
GROUP BY patient_outcome
ORDER BY total_patients DESC;

-- Find total patients by Satisfaction
SELECT
    Satisfaction,
    COUNT(Satisfaction) AS total_patients
FROM gold.fact_bills
GROUP BY Satisfaction
ORDER BY total_patients DESC;

-- What is the total bill paid by each insurance provider?
SELECT
    Insurance_provider,
    SUM(Total_bill) AS total_bill
FROM gold.fact_bills
GROUP BY Insurance_provider
ORDER BY total_bill DESC;

-- What is the total bill by each patient?
SELECT
    patient_id,
    SUM(Total_bill) AS total_bill
FROM gold.fact_bills
GROUP BY patient_id
ORDER BY total_bill DESC;

-- What is the total amount by each payment_status?
SELECT
    payment_status,
    SUM(total_bill) AS total_bill,
	SUM(patient_bill) AS patient_bill,
	SUM(insurance_bill) AS insurance_bill
FROM gold.fact_bills
GROUP BY payment_status
ORDER BY total_bill DESC;

-- What is the average amount by each payment_status?
SELECT
    payment_status,
    AVG(total_bill) AS average_total_bill,
	AVG(patient_bill) AS average_patient_bill,
	AVG(insurance_bill) AS average_insurance_bill
FROM gold.fact_bills
GROUP BY payment_status
ORDER BY total_bill DESC;

-- What is the total amount by each day?
SELECT
    Registration_date,
    SUM(total_bill) AS total_bill,
	SUM(patient_bill) AS patient_bill,
	SUM(insurance_bill) AS insurance_bill
FROM gold.fact_bills
GROUP BY Registration_date
ORDER BY total_bill DESC;

-- What is the average amount by day?
SELECT
    Registration_date,
    AVG(total_bill) AS average_total_bill,
	AVG(patient_bill) AS average_patient_bill,
	AVG(insurance_bill) AS average_insurance_bill
FROM gold.fact_bills
GROUP BY Registration_date
ORDER BY average_total_bill DESC;

-- Find total quatity by prestation
SELECT
    prestation,
    SUM(quantity) AS total_by_prestation
FROM gold.fact_medicaments
GROUP BY prestation
ORDER BY total_by_prestation DESC;
