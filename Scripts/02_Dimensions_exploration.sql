/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of differents tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique patient's adress from where patients originate
SELECT DISTINCT 
    Adress
FROM gold.dim_patients
ORDER BY Adress;

-- Retrieve a list of unique patient's age range
SELECT DISTINCT 
    age_range
FROM gold.dim_patients
ORDER BY age_range;

-- Retrieve a list of unique patient's Diagnosis
SELECT DISTINCT 
    Diagnosis
FROM gold.dim_patients
ORDER BY Diagnosis;

-- Retrieve a list of unique patient's insurance provider
SELECT DISTINCT 
    insurance_provider
FROM gold.fact_bills
ORDER BY insurance_provider;

-- Retrieve a list of unique prestation
SELECT DISTINCT 
    prestation
FROM gold.fact_medicaments
ORDER BY prestation;

SELECT * FROM gold.fact_consultation

-- Retrieve a list of unique prestation
SELECT DISTINCT 
    prestation
FROM gold.fact_consultation
ORDER BY prestation;

-- Retrieve a list of unique prestation
SELECT DISTINCT 
    prestation
FROM gold.fact_divers
ORDER BY prestation;
