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

-- Retrieve a list of unique patient_adrress from which patients originate
SELECT DISTINCT 
    Patient_adrress
FROM gold.dim_patients
ORDER BY Patient_adrress;

-- Retrieve a list of unique patient's insurance provider
SELECT DISTINCT 
    insurance_provider
FROM gold.dim_patients
ORDER BY insurance_provider;

-- Retrieve a list of unique patient's Diagnosis
SELECT DISTINCT 
    Diagnosis
FROM gold.dim_patients
ORDER BY Diagnosis;

-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
    prestation
FROM gold.fact_medicaments
ORDER BY prestation;

-- Retrieve a list of unique department
SELECT DISTINCT 
    department 
FROM gold.fact_medicaments
ORDER BY department;
