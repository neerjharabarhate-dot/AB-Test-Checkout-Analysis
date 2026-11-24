# 🛒 A/B Test of Checkout Conversion – E-Commerce Product Analytics

An end-to-end data analytics project designed to evaluate the effectiveness of a modified e-commerce checkout experience through A/B testing. The project combines SQL-based data analysis, Python statistical testing, and interactive Power BI visualisation to compare conversion performance and support data-driven product decisions.

## 1. Project Overview

The A/B Test of Checkout Conversion project evaluates whether a modified checkout experience (Treatment) performs better than the existing checkout experience (Control).

Using a synthetic dataset of 12,000 users, the analysis examines conversion rates, measures the improvement between experiment groups, and applies statistical methods to determine whether the observed difference is statistically significant.

The project follows an end-to-end analytics workflow, from data preparation and SQL analysis to statistical evaluation and business-focused dashboard development.

## 2. Tech Stack

The project was developed using the following tools and technologies:

- 🐘 **PostgreSQL** – Data storage, querying, experiment group analysis, and conversion performance comparison.
- 🐍 **Python** – Data exploration, statistical analysis, hypothesis testing, and result interpretation.
- 🧮 **Pandas & NumPy** – Data manipulation, aggregation, and numerical calculations.
- 📈 **SciPy & Statsmodels** – Two-proportion Z-test, confidence interval estimation, and Sample Ratio Mismatch (SRM) testing.
- 📊 **Matplotlib** – Statistical result visualisation.
- 📉 **Power BI** – Interactive dashboard development and business insight presentation.
- 📝 **Jupyter Notebook** – Python analysis and documentation.
- 
## 3. Dataset Overview

The project uses a synthetic e-commerce A/B testing dataset containing 12,000 user records across two experiment groups: Control and Treatment.

The dataset consists of three columns:

| Column | Description |
|---|---|
| `user_id` | Unique identifier assigned to each user |
| `variant` | Experiment group assigned to the user (Control or Treatment) |
| `converted` | Indicates whether the user completed a purchase (1 = Yes, 0 = No) |

The dataset captures user-level experiment assignments and conversion outcomes, providing the foundation for comparing checkout performance and evaluating the effectiveness of the modified experience.

## 4. Features & Analytical Highlights

### Business Problem

E-commerce businesses continuously look for ways to improve their checkout experience and increase purchase conversions.

However, introducing a modified checkout experience does not guarantee better results. Product teams need a reliable way to compare the existing and modified experiences before making rollout decisions.

This project addresses the following questions:

- Does the modified checkout experience improve conversion?
- How does Treatment perform compared with Control?
- What is the absolute and relative conversion lift?
- Is the observed difference statistically significant?
- Is the experiment allocation balanced?
- Does the statistical evidence support considering Treatment for rollout?

### Goal of the Project

To develop an end-to-end A/B testing analysis that:

- Compares conversion performance between Control and Treatment.
- Measures absolute and relative conversion lift.
- Evaluates statistical significance using hypothesis testing.
- Estimates the 95% confidence interval.
- Validates experiment allocation using SRM analysis.
- Communicates findings through an interactive Power BI dashboard.

### Key Analysis & Methodology

**1. Data Preparation & Exploration (Python)**

- Loaded and inspected the dataset.
- Examined data types, missing values, duplicate records, and unique users.
- Validated experiment groups and binary conversion outcomes.

**2. Experiment Group Analysis (PostgreSQL)**

- Calculated total assigned users in each group.
- Identified converted and non-converted users.
- Calculated group-wise conversion rates.
- Examined experiment allocation proportions.

**3. Conversion Performance Comparison (SQL & Python)**

- Compared Control and Treatment conversion rates.
- Calculated absolute conversion lift.
- Measured relative conversion improvement.

**4. Statistical Analysis (Python)**

- Formulated Null and Alternative Hypotheses.
- Conducted a two-proportion Z-test.
- Evaluated the p-value at a 5% significance level.
- Calculated the 95% confidence interval.
- Performed Sample Ratio Mismatch (SRM) testing.
- Applied a predefined decision rule to evaluate the experiment results.

### Key Statistical Findings

| Metric | Result |
|---|---|
| Total Assigned Users | 12,000 |
| Control Conversion Rate | 11.27% |
| Treatment Conversion Rate | 13.16% |
| Absolute Conversion Lift | +1.90 pp |
| Relative Conversion Lift | +16.83% |
| Z-Test P-Value | 0.001512 |
| 95% Confidence Interval | +0.73 to +3.07 pp |
| SRM P-Value | 0.869482 |

### Power BI Dashboard

The Power BI report is designed as a focused, two-page decision-support dashboard.

**Page 1 – Experiment Overview**

Provides an executive-level view of experiment performance through:

- Total assigned users and conversion KPI cards.
- Control vs Treatment conversion rate comparison.
- Conversion vs non-conversion comparison.
- Experiment allocation visualisation.
- Dynamic executive summary of the experiment outcome.

**Page 2 – Statistical Evidence & Experiment Health**

Provides a detailed assessment of experiment reliability through:

- 95% confidence interval visualisation.
- P-value and statistical significance.
- SRM analysis and allocation validation.
- Data-quality checks.
- Final experiment decision and business interpretation.

### Business Impact & Insights

**Product Decision-Making:** Helps product teams evaluate whether a modified checkout experience demonstrates improved conversion performance.

**Experiment Evaluation:** Uses statistical testing and confidence intervals to distinguish observed differences from evidence of a meaningful population-level effect.

**Experiment Reliability:** Evaluates group allocation and data quality to identify potential issues that could affect interpretation.

**Rollout Recommendation:** Provides an evidence-based recommendation while highlighting the need to monitor additional business guardrails before full implementation.

## 5. Final Business Conclusion

The Treatment group achieved a conversion rate of 13.16%, compared with 11.27% for the Control group, representing an absolute improvement of approximately 1.90 percentage points and a relative lift of 16.83%.

The two-proportion Z-test produced a p-value of 0.001512, below the 0.05 significance threshold. The 95% confidence interval was entirely above zero, and the SRM test did not detect a significant allocation mismatch.

Based on the predefined statistical decision rule, the Treatment experience is a promising candidate for rollout. However, additional commercial guardrails, including revenue, checkout errors, refunds, and customer experience, should be evaluated before full implementation.

**Note:** These findings are based on synthetic educational data and should not be interpreted as actual business performance improvements.

## 6. Screenshots & Demo

The repository includes visual previews of the Power BI dashboard and supporting analysis outputs.

- Experiment Overview Dashboard
- Statistical Evidence & Experiment Health Dashboard
- Python Statistical Analysis
- SQL Analysis Queries

## 7. Repository Structure

AB-Test-Checkout-Analysis/
│
├── README.md
│
├── ab_testing_python_analysis.ipynb
│
├── AB_Test_SQL_Analysis.sql
│
├── AB_Test_Powerbi_Dashboard.pbix
│
└── Screenshots/
    ├── Home_Page.png
    ├── Experiment_Overview.png
    └── Statistical_Evidence.png
    
**Note:** The original dataset is not included in this repository. Refer to the Data Source & Attribution section for the original dataset location.
