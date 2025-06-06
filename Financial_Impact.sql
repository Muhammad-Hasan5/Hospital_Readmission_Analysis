--cost of readmitted vs. non-readmitted
SELECT
    EXTRACT(YEAR FROM admission_date) AS year,
    SUM(cost) FILTER(WHERE readmitted = 'Yes') AS cost_of_readmissions,
    SUM(cost) FILTER(WHERE readmitted = 'No') AS cost_of_non_readmissions
FROM
    visits
GROUP BY
    EXTRACT(YEAR FROM admission_date)

--billing by department with readmissions %
WITH sorted_visits as (
    SELECT 
        patient_id,
        admission_date,
        discharge_date,
        department,
        bill_paid,
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
    department,
    COUNT(*) FILTER(WHERE is_readmitted_within_30days = 1) * 100.0 / COUNT(*)
    AS readmitted_rate_30days,
    SUM(bill_paid)
FROM
    readmission_flag
WHERE
    next_admission_date IS NOT NULL
GROUP BY
    EXTRACT(YEAR FROM admission_date),
    EXTRACT(MONTH FROM admission_date),
    department
ORDER BY 
    EXTRACT(YEAR FROM admission_date),
    EXTRACT(MONTH FROM admission_date),
    SUM(bill_paid) DESC,
    COUNT(*) FILTER(WHERE is_readmitted_within_30days = 1) * 100.0 / COUNT(*) DESC

--High Burden Patients
SELECT
    EXTRACT(YEAR FROM admission_date) AS year,
    patient_id,
    COUNT(visit_id) AS no_of_visits,
    SUM(cost) AS cost_spent
FROM
    visits
GROUP BY
    EXTRACT(YEAR FROM admission_date),
    patient_id
ORDER BY
    COUNT(visit_id) DESC,
    SUM(cost) DESC
LIMIT 100;
