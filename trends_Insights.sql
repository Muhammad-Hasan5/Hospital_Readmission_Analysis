--number of normal vs abnormal labs according to diagnosis
SELECT 
    EXTRACT(YEAR FROM v.admission_date) AS admission_year,
    d.diagnosis,
    
    COUNT(*) FILTER (WHERE l.status = 'Abnormal') AS abnormal_lab_count,
    COUNT(*) FILTER (WHERE l.status = 'Normal') AS normal_lab_count,
    COUNT(*) AS total_labs,
    
    ROUND(
        COUNT(*) FILTER (WHERE l.status = 'Abnormal') * 100.0 / NULLIF(COUNT(*), 0), 2
    ) AS abnormal_lab_percentage,
    
    ROUND(
        COUNT(*) FILTER (WHERE l.status = 'Normal') * 100.0 / NULLIF(COUNT(*), 0), 2
    ) AS normal_lab_percentage

FROM 
    diagnoses d
JOIN 
    labs l ON d.visit_id = l.visit_id
JOIN
    visits v ON d.visit_id = v.visit_id
GROUP BY 
    admission_year, d.diagnosis
ORDER BY 
    admission_year, abnormal_lab_percentage DESC;



--top lab tests linked to readmission
SELECT 
    l.lab_test,
    COUNT(v.visit_id) as number_of_tests
FROM
    labs AS l  
JOIN visits AS v ON l.visit_id = v.visit_id
WHERE
    v.readmitted = 'Yes'
GROUP BY
    l.lab_test
ORDER BY
    COUNT(v.visit_id) DESC;

--Age group vs. readmissions
WITH age_buckets AS (
    SELECT
        patient_id,
        CASE
            WHEN age BETWEEN 0 AND 1 THEN 'Infant'
            WHEN age BETWEEN 2 AND 5 THEN 'Toddler'
            WHEN age BETWEEN 6 AND 12 THEN 'Child'
            WHEN age BETWEEN 13 AND 17 THEN 'Adolescent'
            WHEN age BETWEEN 18 AND 25 THEN 'Young Adult'
            WHEN age BETWEEN 26 AND 39 THEN 'Adult'
            WHEN age BETWEEN 40 AND 59 THEN 'Middle-Aged Adult'
            WHEN age BETWEEN 60 AND 74 THEN 'Elderly'
            ELSE 'Geriatric'
        END AS Age_group
    FROM
        patients
    ORDER BY
        patient_id
), readmissions AS (
    SELECT
        EXTRACT(YEAR FROM v.admission_date) AS year,
        a.Age_group,
        COUNT(v.visit_id) AS no_of_readmission
    FROM
        age_buckets AS a 
    JOIN visits AS v ON a.patient_id = v.patient_id
    WHERE
        v.readmitted = 'Yes'
    GROUP BY
        EXTRACT(YEAR FROM v.admission_date),
        a.Age_group
    ORDER BY
        COUNT(v.visit_id) DESC
)
SELECT * FROM readmissions;
