--Counting total patients
SELECT
    COUNT(*) as total_patients
FROM
    patients;

--calculating readmission rate within 30 days
WITH sorted_visits as (
    SELECT 
        patient_id,
        admission_date,
        discharge_date,
        LEAD(admission_date) OVER(
                                  PARTITION BY patient_id
                                  ORDER BY admission_date) as next_admission_date
    FROM
        visits
), 
readmission_flag as (
    SELECT 
        *,
        CASE
            WHEN next_admission_date IS NOT NULL
                 AND next_admission_date <= discharge_date + INTERVAL '30 days'
            THEN 1
            ELSE 0
        END AS is_readmitted_within_30days
    FROM 
        sorted_visits
)

SELECT 
    COUNT(*) FILTER(WHERE is_readmitted_within_30days = 1) * 100.0 / COUNT(*)
    AS readmitted_rate_30days
FROM
    readmission_flag
WHERE
    next_admission_date IS NOT NULL;

--avg. length of stay(LOS)
SELECT 
    ROUND(AVG(length_of_stay), 2) as avg_LOS
FROM
    visits;

--avg. cost per readmission
WITH sorted_visits as (
    SELECT 
        patient_id,
        admission_date,
        discharge_date,
        cost,
        LEAD(admission_date) OVER(
                                  PARTITION BY patient_id
                                  ORDER BY admission_date) as next_admission_date
    FROM
        visits
), 
readmission_flag as (
    SELECT 
        *,
        CASE
            WHEN next_admission_date IS NOT NULL
                 AND next_admission_date <= discharge_date + INTERVAL '30 days'
            THEN 1
            ELSE 0
        END AS is_readmitted_within_30days
    FROM 
        sorted_visits
)

SELECT 
    AVG(cost) FILTER(WHERE is_readmitted_within_30days = 1) AS avg_cost_per_readmission
FROM
    readmission_flag
WHERE
    next_admission_date IS NOT NULL;

--% of abnormal and normal lab results
WITH visit_status AS (
    SELECT
        visit_id,
        BOOL_AND(status = 'Normal') AS all_normal,
        BOOL_AND(status = 'Abnormal') AS all_abnormal
    FROM labs
    GROUP BY visit_id
),
classified_visits AS (
    SELECT
        CASE
            WHEN all_normal THEN 'Normal'
            WHEN all_abnormal THEN 'Abnormal'
            ELSE 'Mixed'
        END AS visit_type
    FROM visit_status
)
SELECT
    visit_type,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
FROM classified_visits
WHERE visit_type IN ('Normal', 'Abnormal')  
GROUP BY visit_type;

--monthly readmission rate
WITH sorted_visits as (
    SELECT 
        patient_id,
        admission_date,
        discharge_date,
        LEAD(admission_date) OVER(
                                  PARTITION BY patient_id
                                  ORDER BY admission_date) as next_admission_date
    FROM
        visits
), 
readmission_flag as (
    SELECT 
        *,
        CASE
            WHEN next_admission_date IS NOT NULL
                 AND next_admission_date <= discharge_date + INTERVAL '30 days'
            THEN 1
            ELSE 0
        END AS is_readmitted_within_30days
    FROM 
        sorted_visits
)

SELECT 
    EXTRACT(YEAR FROM admission_date) as year,
    EXTRACT(MONTH FROM admission_date) as month,
    COUNT(*) FILTER(WHERE is_readmitted_within_30days = 1) * 100.0 / COUNT(*)
    AS readmitted_rate_30days
FROM
    readmission_flag
WHERE
    next_admission_date IS NOT NULL
GROUP BY
    EXTRACT(YEAR FROM admission_date),
    EXTRACT(MONTH FROM admission_date)
ORDER BY 
    EXTRACT(YEAR FROM admission_date),
    EXTRACT(MONTH FROM admission_date)

--Top 5 Diagnoses causing readmissions
SELECT
    EXTRACT(YEAR FROM v.admission_date) AS year,
    EXTRACT(MONTH FROM v.admission_date) AS month,
    d.diagnosis,
    COUNT(v.visit_id) 
FROM
    visits AS v 
JOIN diagnoses AS d ON v.visit_id = d.visit_id
WHERE
    v.readmitted = 'Yes'
GROUP BY
    EXTRACT(YEAR FROM v.admission_date),
    EXTRACT(MONTH FROM v.admission_date),
    d.diagnosis 
ORDER BY
    EXTRACT(YEAR FROM v.admission_date),
    EXTRACT(MONTH FROM v.admission_date),
    COUNT(v.visit_id) DESC


--department wise readmission
SELECT 
    EXTRACT(YEAR FROM admission_date) AS year,
    EXTRACT(MONTH FROM admission_date) AS month,
    department,
    COUNT(*) as no_of_readmission
FROM
    visits
WHERE
    readmitted = 'Yes'
GROUP BY
    EXTRACT(YEAR FROM admission_date),
    EXTRACT(MONTH FROM admission_date),
    department
ORDER BY
    EXTRACT(YEAR FROM admission_date),
    EXTRACT(MONTH FROM admission_date),
    COUNT(visit_id) DESC;