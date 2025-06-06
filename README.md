# Hospital Readmission Analysis Dashboard

## 📋 Overview

This project analyzes hospital readmission data to identify high-risk factors and reduce avoidable readmissions. It provides interactive dashboards to visualize key KPIs, risk drivers, and financial impact.

 ## 🎯 Objectives

 - Identify avoidable readmissions.
- Analyze lab, diagnosis, and demographic risk drivers.
- Highlight high-burden patients.
- Support cost-saving strategies.

##  📊 Dashboard Pages

### 🔹 Overview Tab
- This section supports clinical and administrative teams in identifying priority areas for intervention and optimizing resource allocation.

- Displays KPIs:

    1. total patients
    2. readmission rate 
    3. average LOS
    4. cost per readmission.
- Charts: 
    1. Monthly readmission trend 
    2. top diagnoses 
    3. department-wise readmissions.   

### 🔹 Risk Driver Tab
- This section enables early identification of vulnerable patients and supports targeted clinical interventions to reduce readmission rates.

- Charts:

    1. Abnormal vs. Normal Labs
    2. Age Group wise Re-admission

- Tables:

    1. Diagnosis vs. Lab Abnormality
    2. Top 5 labs linked to return

- Explores relationships between diagnosis lab abnormalities, and readmissions.
- Includes charts on abnormal labs, age groups, and top lab tests linked to returns.

### 🔹 Financial Impact Tab
- Charts:

    1. Hospital's Expenditure on re-admissions vs. non-readmissions
    2. High Burden Patient: Top 100
    3. Department vs. Re-admission rate vs. Bill paid
    
- Compares cost of readmitted vs. non-readmitted patients.
- Highlights top 100 high-burden patients.
- Departmental billing insights with readmission percentages.

## 🔍 Key Insights

- Patients with abnormal labs have a 3x higher chance of re-admission.
- Age 60+ group shows significantly higher risk of re-admission.
- Top 5 diagnoses contribute to 70% of readmissions.
- 100 high-burden patients account for 40% of total readmission costs.

## 📈 Strategic Recommendations

- Prioritize targeted follow-ups for high-risk age groups and diagnoses.
- Implement lab result alerts for discharge decision-making.
- Develop personalized care plans for high-burden patients.

##  🛠 Tools Used

- Microsoft Excel 
- PostgreSQL 
- Data Source: Simulated hospital EHR data

## Dashboard Snapshots

### Overview Tab:
![Overview Tab](/Overview%20Tab.png)

### Risk Drivers Tab:
![Risk Drivers Tab](/Risk%20Drivers%20Tab.png)

### Financial Impact Tab:
![Financial Impact Tab](/Financial%20Impact%20Tab.png)

## Age Grouping


| Age Bucket Label         | Age Range (Years) | Description                         |
| ------------------------ | ----------------- | ----------------------------------- |
| Infant                   | 0–1               | Newborns and infants                |
| Toddler/Preschool        | 2–5               | Early childhood                     |
| Child                    | 6–12              | Primary school children             |
| Adolescent               | 13–17             | Teenagers                           |
| Young Adult              | 18–25             | College-age to early workers        |
| Adult                    | 26–39             | Young to mid-career adults          |
| Middle-Aged Adult        | 40–59             | Pre-retirement, higher chronic risk |
| Senior / Elderly         | 60–74             | Retirement age, increasing risk     |
| Advanced Age / Geriatric | 75+               | Very elderly, high care needs       |


##  🧾 Note

This project is based on synthetic data generated using PostgreSQL. However, all analysis, logic, and methodologies follow industry standards, ensuring the insights and techniques are highly applicable to real-world healthcare scenarios.




