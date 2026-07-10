/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/

SELECT * FROM gold.dim_patients
-- Which gender categories contribute the most?
WITH category AS (
    SELECT
        Gender,
        COUNT(Gender) AS total_patients
    FROM gold.dim_patients
    GROUP BY Gender
)
SELECT
    Gender,
    total_patients,
    SUM(total_patients) OVER () AS overall_patients,
    ROUND((CAST(total_patients AS FLOAT) / SUM(total_patients) OVER ()) * 100, 2) AS percentage_of_total
FROM category
ORDER BY total_patients DESC;

-- Which age range categories contribute the most?

WITH category AS (
    SELECT
        age_range,
        COUNT(age_range) AS total_patients
    FROM gold.dim_patients
    GROUP BY age_range
)
SELECT
    age_range,
    total_patients,
    SUM(total_patients) OVER () AS overall_patients,
    ROUND((CAST(total_patients AS FLOAT) / SUM(total_patients) OVER ()) * 100, 2) AS percentage_of_total
FROM category
ORDER BY total_patients DESC;

-- Which patient outcome categories contribute the most?

WITH category AS (
    SELECT
        patient_outcome,
        COUNT(patient_outcome) AS total_patients
    FROM gold.dim_patients
    GROUP BY patient_outcome
)
SELECT
    patient_outcome,
    total_patients,
    SUM(total_patients) OVER () AS overall_patients,
    ROUND((CAST(total_patients AS FLOAT) / SUM(total_patients) OVER ()) * 100, 2) AS percentage_of_total
FROM category
ORDER BY total_patients DESC;

-- Which patient Adress contribute the most?

WITH category AS (
    SELECT
        Adress,
        COUNT(Adress) AS total_patients
    FROM gold.dim_patients
    GROUP BY Adress
)
SELECT
    Adress,
    total_patients,
    SUM(total_patients) OVER () AS overall_patients,
    ROUND((CAST(total_patients AS FLOAT) / SUM(total_patients) OVER ()) * 100, 2) AS percentage_of_total
FROM category
ORDER BY total_patients DESC;

-- Which Diagnosis contribute the most?

WITH category AS (
    SELECT
        Diagnosis,
        COUNT( Diagnosis) AS total_patients
    FROM gold.dim_patients
    GROUP BY  Diagnosis
)
SELECT
     Diagnosis,
    total_patients,
    SUM(total_patients) OVER () AS overall_patients,
    ROUND((CAST(total_patients AS FLOAT) / SUM(total_patients) OVER ()) * 100, 2) AS percentage_of_total
FROM category
ORDER BY total_patients DESC;

SELECT * FROM gold.fact_bills

-- Which Insurance provider categories paid the most to overall bills?
WITH category AS (
    SELECT
        Insurance_provider,
        SUM(Total_bill) AS total_bills
    FROM gold.fact_bills
    GROUP BY Insurance_provider
)
SELECT
    Insurance_provider,
    total_bills,
    SUM(total_bills) OVER () AS overall_bills,
    ROUND((CAST(total_bills AS FLOAT) / SUM(total_bills) OVER ()) * 100, 2) AS percentage_of_total
FROM category
ORDER BY total_bills DESC;

-- Which payment status categories paid the most to overall bills?
WITH category AS (
    SELECT
        payment_status,
        SUM(Total_bill) AS total_bills
    FROM gold.fact_bills
    GROUP BY payment_status
)
SELECT
    payment_status,
    total_bills,
    SUM(total_bills) OVER () AS overall_bills,
    ROUND((CAST(total_bills AS FLOAT) / SUM(total_bills) OVER ()) * 100, 2) AS percentage_of_total
FROM category
ORDER BY total_bills DESC;

-- Which Satisfaction categories paid the most to overall bills?
WITH category AS (
    SELECT
        Satisfaction,
        SUM(Total_bill) AS total_bills
    FROM gold.fact_bills
    GROUP BY Satisfaction
)
SELECT
    Satisfaction,
    total_bills,
    SUM(total_bills) OVER () AS overall_bills,
    ROUND((CAST(total_bills AS FLOAT) / SUM(total_bills) OVER ()) * 100, 2) AS percentage_of_total
FROM category
ORDER BY total_bills DESC;

SELECT * FROM gold.fact_medicaments

-- Which prestation contribute the most to overall bill?
WITH category AS (
    SELECT
        prestation,
        SUM(Total_Price) AS total_price
    FROM gold.fact_medicaments
    GROUP BY prestation
)
SELECT
    prestation,
    total_price,
    SUM(total_price) OVER () AS overall_price,
    ROUND((CAST(total_price AS FLOAT) / SUM(total_price) OVER ()) * 100, 2) AS percentage_of_total
FROM category
ORDER BY total_price DESC;
