# 📊 Reducing Avoidable Re-admissions in Hospitals – Dashboard 

## 📋 Overview

Hospital readmissions are more than just a metric—they're a signal. They tell us where the system is breaking down, where care is incomplete, and where patients need more support. This dashboard was created as part of a data-driven initiative to uncover the hidden patterns behind high readmission rates and help hospitals contain costs, prioritize interventions, and ultimately save lives.

# 📌 Real-World Problem
Every year, U.S. hospitals lose billions to avoidable readmissions. Beyond the financial burden, readmissions lead to patient distress, clinician burnout, and systemic inefficiencies. The goal of this project is to bring visibility to:

- Which departments are struggling the most?

- What diagnoses are repeatedly causing return visits?

- Which patients are at highest risk and why?

- What are the financial implications of readmission trends?

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

- 100K patients analyzed with a 13.37% monthly readmission rate.

- Identifies top 5 diagnoses driving returns: Diabetes, GERD, Myocardial Infarction, etc.

- Forecasts monthly readmission trends through Dec 2025 using time series modeling.

- Department-wise breakdown shows Cardiology and Oncology leading in readmissions.

⚠️ Risk Drivers Tab

 ![Overview Tab](/Overview%20Tab.png)

### 🔹 Risk Driver Tab
- This section enables early identification of vulnerable patients and supports targeted clinical interventions to reduce readmission rates.

- Charts:

    1. Abnormal vs. Normal Labs
    2. Age Group wise Re-admission

- Tables:

    1. Diagnosis vs. Lab Abnormality
    2. Top 5 labs linked to return

- Reveals key risk indicators such as abnormal lab results and vulnerable age groups.

- Geriatric and middle-aged adults top the list of readmitted demographics.

- Strong correlation between diagnoses (e.g., diabetes, hypertension) and lab abnormalities.

- Lists top 5 lab tests (Creatinine, CBC, Blood Sugar) linked to return visits.

  ![Risk Drivers Tab](/Risk%20Drivers%20Tab.png)

### 🔹 Financial Impact Tab
- Charts:

    1. Hospital's Expenditure on re-admissions vs. non-readmissions
    2. High Burden Patient: Top 100
    3. Department vs. Re-admission rate vs. Bill paid
    
- Compares readmission vs. non-readmission costs (2023–2025).

- Highlights high-burden patients (Top 100) whose treatment cost curves demand attention.

- Cross-analysis between departments shows ICU and Pediatrics with high costs and readmission rates.

- Strategic callouts for targeted cost containment and policy optimization.

  ![Financial Impact Tab](/Financial%20Impact%20Tab.png)

## 🔍 Key Insights

✅ Departments like Cardiology and ICU have the highest readmission rates—warranting better discharge planning and follow-up.

✅ Abnormal lab results show strong ties to repeat visits, making early diagnostics a critical intervention point.

✅ Geriatric patients, often with multiple comorbidities, require holistic care planning.

✅ Readmission costs rose from $0.20B to $0.23B—a trend projected to increase without action.

✅ Predictive modeling shows a potential spike in readmission rates post-April 2025, emphasizing the need for preventive strategies now.

##  🛠 Tools Used

- Microsoft Excel 
- PostgreSQL 
- Data Source: Simulated hospital EHR data


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




