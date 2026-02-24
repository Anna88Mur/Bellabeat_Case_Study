
  <img src="assets/banner.png" alt="Bellabeat Case Study — Google Data Analytics Project">


## Project for the Google Data Analytics Certificate

This project was completed as part of the Google Data Analytics Certificate program and is based on a fictional business scenario provided in the course.

### Scenario

I am a junior data analyst working on the marketing analytics team at **Bellabeat**, a high‑tech manufacturer of health‑focused products for women. Bellabeat is a successful small company with the potential to become a larger player in the global smart‑device market.

Urška Sršen, Bellabeat’s cofounder and Chief Creative Officer, believes that analyzing smart‑device fitness data could help unlock new growth opportunities. I have been asked to focus on one of Bellabeat’s products and analyze smart‑device usage data to gain insight into how consumers use their devices. These insights will guide high‑level marketing recommendations for the Bellabeat executive team.

### Data Source

The primary dataset used in this project is available on Kaggle.

***FitBit Fitness Tracker Data:***  
https://www.kaggle.com/datasets/arashnic/fitbit?resource=download-directory  

Additional data sources may be used if needed.

---

## Methodology

We follow the six-step data analysis process recommended in the Google Data Analytics Certificate:

- <span style="color:#d9534f; font-weight:bold;">ASK</span>  
- <span style="color:#f0ad4e; font-weight:bold;">PREPARE</span>  
- <span style="color:#5bc0de; font-weight:bold;">PROCESS</span>  
- <span style="color:#5cb85c; font-weight:bold;">ANALYZE</span>  
- <span style="color:#428bca; font-weight:bold;">SHARE</span>  
- <span style="color:#6f42c1; font-weight:bold;">ACT</span>

## <span style="color:#d9534f; font-weight:bold;">ASK</span>

Sršen asks me to analyze smart device usage data in order to gain insight into how
consumers use non-Bellabeat smart devices. These questions will guide my
analysis:
1. What are some trends in smart device usage?
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat marketing strategy?

In this stage, I define the business problem, identify key stakeholders, and clarify what insights are needed to support Bellabeat’s strategic decisions. The goal of the ASK phase is to understand what the company wants to achieve and how data can help answer these questions.
The key stakeholders in this project are Bellabeat’s executive team, who are interested in understanding how smart‑device usage trends can support the future development and growth of Bellabeat products.

## <span style="color:#f0ad4e; font-weight:bold;">PREPARE</span>  

The primary dataset used in this project is the public **FitBit Fitness Tracker Data**  
<https://www.kaggle.com/datasets/arashnic/fitbit?resource=download-directory>

This dataset contains two months of smart‑device activity recorded between 03/12/2016 and 05/12/2016.  
Thirty Fitbit users voluntarily submitted their personal tracker data, including minute‑level records of physical activity, heart rate, and sleep monitoring. Each month is provided as a separate set of CSV files.

### Limitations of the Fitbit Fitness Tracker Dataset
Although the Fitbit dataset provides valuable behavioral insights, it has several limitations:
- Small sample size
- Self‑selected participants
Users volunteered to share their data, introducing self‑selection bias.
- Limited time range
- Lack of demographic information, such as:
- age
- gender
- occupation
- health conditions
- lifestyle factors
Because the Fitbit dataset is fragmented and lacks demographic context, I added a second data source to enrich the analysis.


### Additional Data Source
To explore sleep behavior in more detail, I used a synthetic lifestyle dataset from Kaggle that includes variables not available in the Fitbit data.

**Sleep health & lifestyle dataset:**

https://www.kaggle.com/code/manarmohamed24/sleep-health-lifestyle-dataset/notebook

Although the dataset is synthetic, it provides structured demographic and lifestyle variables that are missing from the Fitbit data. This makes it a useful complementary source for exploring how factors such as stress, physical activity, sleep disorders, or work schedules may influence sleep quality. While the values are artificially generated, the relationships between variables are realistic enough to support exploratory analysis and help contextualize behavioral patterns observed in the Fitbit dataset.



## <span style="color:#5bc0de; font-weight:bold;">PROCESS</span>

I conducted the initial data exploration in **Google Sheets**, using sorting, filtering, and duplicate removal.

### Merging monthly files

To combine files from different months, I used a vertical array formula:

```gs
={Sheet6!A:Z; Sheet7!A:Z}
```

Since the column names were identical, merging did not cause structural issues.
However, duplicates appeared after merging, and I removed them during cleaning.

### Reconstructing missing daily files
The March and April folders did not include daily‑level files.
To rebuild daily summaries from hourly‑level data, I used two formulas.
Example for reconstructing sleepDay_merged:

1. Extract unique combinations of user + date:
```gs
=UNIQUE(FILTER({minuteSleep_merged!A2:A, ARRAYFORMULA(INT(minuteSleep_merged!B2:B))},minuteSleep_merged!B2:B <> ""))
```
2. Count minutes asleep for each user per day:

```gs
=COUNTIFS(minuteSleep_merged!A2:A, $A2, minuteSleep_merged!E2:E, $B2, minuteSleep_merged!C2:C, 1)
```

For other datasets, SUMIFS() was more appropriate for aggregating numeric values.

### Fixing datetime format issues
In some files, ActivityHour was stored as 3/12/2016 12:00:00 AM

This format complicates SQL queries, so I split it into two columns:
**Date**
```gs
=ARRAYFORMULA(INT(E2:E))
```
**Time**
```gs
=TEXT(E2, "HH:mm:ss")
```

Final cleaned files prepared for analysis

- dailyActivity_merged.csv
- dailyCalories_merged.csv
- dailySteps_merged.csv
- hourlyCalories_merged.csv
- hourlyIntensities_merged.csv
- hourlySteps_merged.csv
- sleepDay_merged.csv

All cleaned and merged datasets used in this project are available in the repository at:  

[**SQL/data**](SQL/data)


## <span style="color:#5cb85c; font-weight:bold;">ANALYZE</span>

The analysis of the **FitBit Fitness Tracker Data** was conducted using Google BigQuery, where SQL queries were used to  aggregate and explore the behavioral patterns captured in the dataset. A detailed report is available here: [**SQL**](SQL)

The **Sleep Health & Lifestyle Dataset** was analyzed separately in RStudio (version 2026.01.0), using R for statistical exploration, visualization, and modeling. The full analysis can be found here: [**R**](R)

Using two different analytical environments allowed me to apply the most suitable tools for each dataset and to explore the data from complementary perspectives.

## <span style="color:#428bca; font-weight:bold;">SHARE</span>

The results of this case study are summarized in a presentation format.  
The final report is available as a PDF file:

**Bellabeat_Case_Study.pdf**

This presentation highlights the key findings, visualizations, and recommendations derived from the analysis.


## <span style="color:#6f42c1; font-weight:bold;">ACT</span>

The combined SQL and R analyses show that sleep behavior is shaped far more by stress, lifestyle habits, and individual health conditions than by physical activity alone. While steps and activity levels demonstrate only weak relationships with sleep outcomes, stress consistently emerges as a meaningful predictor of both sleep duration and perceived sleep quality. Users with diagnosed sleep disorders also show distinct patterns that align with known clinical expectations.
What Bellabeat Can Do Next
- **Prioritize stress‑focused insights**

Integrate stress‑tracking signals and provide personalized recommendations for relaxation, evening routines, and digital‑detox habits.
- **Enhance sleep‑hygiene guidance**

Offer actionable tips around bedtime consistency, screen exposure, and wind‑down rituals, as these factors likely influence sleep latency and quality more than steps.
- **Segment users by sleep patterns**

Identify groups with short sleep, low sleep quality, or irregular routines and tailor notifications or coaching to their specific needs.

- **Highlight holistic wellness, not just activity**

Position Bellabeat as a tool that connects stress, lifestyle, and sleep—not only physical movement—to support women’s overall well‑being.

- **Use disorder‑related patterns carefully**

While the dataset is not clinical, the differences between groups suggest an opportunity for educational content about recognizing early signs of sleep issues.
