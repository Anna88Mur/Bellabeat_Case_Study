# 1. Average hourly intensity

SELECT
  EXTRACT(HOUR FROM Time) AS HourOfDay,
  ROUND(AVG(TotalIntensity),2) AS AvgIntensity
FROM `bellabitcasestudy-487716.FitBit.HourlyIntensities`
GROUP BY HourOfDay
ORDER BY HourOfDay;

#2. Peak hourly intensity
SELECT
  EXTRACT(HOUR FROM Time) AS HourOfDay,
  MAX(TotalIntensity) AS MaxIntensity
FROM `bellabitcasestudy-487716.FitBit.HourlyIntensities`
GROUP BY HourOfDay
ORDER BY HourOfDay;

#Combined hourly analysis (intensity + steps + calories)
SELECT
  EXTRACT(HOUR FROM i.Time) AS HourOfDay,
  AVG(i.TotalIntensity) AS AvgIntensity,
  AVG(s.StepTotal) AS AvgSteps,
  AVG(c.Calories) AS AvgCalories
FROM `bellabitcasestudy-487716.FitBit.HourlyIntensities` i
JOIN `bellabitcasestudy-487716.FitBit.hourlySteps` s
  ON i.Id = s.Id AND i.Date = s.Date AND i.Time = s.Time
JOIN `bellabitcasestudy-487716.FitBit.hourlyCalories` c
  ON i.Id = c.Id AND i.Date = c.Date AND i.Time = c.Time
GROUP BY HourOfDay
ORDER BY HourOfDay;


# CTE version
WITH hourly AS (
  SELECT
    i.Id,
    i.Date,
    i.Time,
    EXTRACT(HOUR FROM i.Time) AS HourOfDay,
    i.TotalIntensity,
    s.StepTotal,
    c.Calories
  FROM `bellabitcasestudy-487716.FitBit.HourlyIntensities` i
  JOIN `bellabitcasestudy-487716.FitBit.hourlySteps` s
    ON i.Id = s.Id AND i.Date = s.Date AND i.Time = s.Time
  JOIN `bellabitcasestudy-487716.FitBit.hourlyCalories` c
    ON i.Id = c.Id AND i.Date = c.Date AND i.Time = c.Time
)

SELECT
  HourOfDay,
  AVG(TotalIntensity) AS AvgIntensity,
  AVG(StepTotal) AS AvgSteps,
  AVG(Calories) AS AvgCalories,
  MAX(TotalIntensity) AS MaxIntensity,
  MAX(StepTotal) AS MaxSteps,
  MAX(Calories) AS MaxCalories
FROM hourly
GROUP BY HourOfDay
ORDER BY HourOfDay;

# 5‑cluster model - 1 = lowest activity hours
# 5 = highest activity hours

WITH hourly AS (
  SELECT
    EXTRACT(HOUR FROM Time) AS HourOfDay,
    AVG(TotalIntensity) AS AvgIntensity
  FROM `bellabitcasestudy-487716.FitBit.HourlyIntensities`
  GROUP BY HourOfDay
)

SELECT
  HourOfDay,
  AvgIntensity,
  NTILE(5) OVER (ORDER BY AvgIntensity) AS IntensityCluster
FROM hourly
ORDER BY HourOfDay;

