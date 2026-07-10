/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g. Patients, Pharmaceutic products, Diagnosis, etc...) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

--I. Adress Exploration
-- Which 5 patients' adress with more patients?
-- Simple Ranking
SELECT TOP 5
    Adress,
    COUNT(Adress) AS total_patients
FROM gold.dim_patients
GROUP BY Adress
ORDER BY total_patients DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        Adress,
		COUNT(Adress) AS total_patients,
        RANK() OVER (ORDER BY COUNT(Adress) DESC) AS rank_patients
    FROM gold.dim_patients
    GROUP BY Adress
    ) AS Ranked
WHERE rank_patients <= 5;

-- Which 5 patients' adress with less patients?
SELECT TOP 5
    Adress,
    COUNT(Adress) AS total_patients
FROM gold.dim_patients
GROUP BY Adress
ORDER BY total_patients;

--II. Diagnosis Exploration
-- Which 5 patients' Diagnostic with more patients?
-- Simple Ranking
SELECT TOP 10
    Diagnosis,
    COUNT(Diagnosis) AS total_patients
FROM gold.dim_patients
GROUP BY Diagnosis
ORDER BY total_patients DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        Diagnosis,
		COUNT(Diagnosis) AS total_patients,
        RANK() OVER (ORDER BY COUNT(Diagnosis) DESC) AS rank_patients
    FROM gold.dim_patients
    GROUP BY Diagnosis
    ) AS Ranked
WHERE rank_patients <= 10;

-- Which 5 patients' adress with less patients?
SELECT TOP 10
    Diagnosis,
    COUNT(Diagnosis) AS total_patients
FROM gold.dim_patients
GROUP BY Adress
ORDER BY total_patients;

--III. Registration date Exploration
-- Which 5 patients' Registration date with more patients?
-- Simple Ranking
SELECT TOP 5
    Registration_date,
    COUNT(Registration_date) AS total_patients
FROM gold.dim_patients
GROUP BY Registration_date
ORDER BY total_patients DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        Registration_date,
		COUNT(Registration_date) AS total_patients,
        RANK() OVER (ORDER BY COUNT(Registration_date) DESC) AS rank_patients
    FROM gold.dim_patients
    GROUP BY Adress
    ) AS Ranked
WHERE rank_patients <= 5;

-- Find the top 10 patients who have paid the highest bill
SELECT TOP 10
    p.patient_id,
    SUM(b.total_bill) AS total_amount
FROM gold.dim_patients p
LEFT JOIN gold.fact_bills b
    ON p.patient_id = b.Patient_id
GROUP BY 
     p.patient_id
ORDER BY total_amount DESC;

-- Find the top 10 patients who have paid the lowest bill
SELECT TOP 10
    p.patient_id,
    SUM(b.total_bill) AS total_amount
FROM gold.dim_patients p
LEFT JOIN gold.fact_bills b
    ON p.patient_id = b.Patient_id
GROUP BY 
     p.patient_id
ORDER BY total_amount;

-- Which 5 Insurance providers Generating the Highest Revenue?
-- Simple Ranking
SELECT TOP 5
    Insurance_provider,
    SUM(Total_bill) AS total_revenue
FROM gold.fact_bills 
GROUP BY Insurance_provider
ORDER BY total_revenue DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        Insurance_provider,
		SUM(Total_bill) AS total_revenue,
        RANK() OVER (ORDER BY SUM(Total_bill) DESC) AS ranking
    FROM gold.fact_bills
    GROUP BY Insurance_provider
) AS ranked_products
WHERE ranking <= 5;

-- Which 5 Insurance providers Generating the lowest Revenue?
SELECT TOP 5
    Insurance_provider,
    SUM(Total_bill) AS total_revenue
FROM gold.fact_bills 
GROUP BY Insurance_provider
ORDER BY total_revenue;

-- Find the top 10 patients who have paid the highest total bill
SELECT TOP 10
    p. patient_id,
    SUM(b.Total_bill) AS total_revenue
FROM gold.fact_bills b
LEFT JOIN gold.dim_patients p
    ON p.patient_id = b.Patient_id
GROUP BY 
    p.patient_id
ORDER BY total_revenue DESC;

-- Find the top 10 patients who have paid the highest total bill
SELECT TOP 10
    p. patient_id,
    SUM(b.Total_bill) AS total_revenue
FROM gold.fact_bills b
LEFT JOIN gold.dim_patients p
    ON p.patient_id = b.Patient_id
GROUP BY 
    p.patient_id
ORDER BY total_revenue;

-- Which 10 pharmaceutic products Generating the Highest Revenue?
-- Simple Ranking
SELECT TOP 10
    prestation,
    SUM(Total_Price) AS total_revenue
FROM gold.fact_medicaments
GROUP BY prestation
ORDER BY total_revenue DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        prestation,
		SUM(Total_Price) AS total_revenue,
        RANK() OVER (ORDER BY SUM(Total_Price) DESC) AS rank_products
    FROM gold.fact_medicaments
    GROUP BY prestation
) AS ranked_products
WHERE rank_products <= 10;

-- Which 10 pharmaceutic products Generating the lowest Revenue?
-- Simple Ranking
SELECT TOP 10
    prestation,
    SUM(Total_Price) AS total_revenue
FROM gold.fact_medicaments
GROUP BY prestation
ORDER BY total_revenue;

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM (
    SELECT
        prestation,
		SUM(Total_Price) AS total_revenue,
        RANK() OVER (ORDER BY SUM(Total_Price) DESC) AS rank_products
    FROM gold.fact_medicaments
    GROUP BY prestation
) AS ranked_products
WHERE rank_products >= 10;
