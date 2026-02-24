SELECT 
  s.Id,
  s.SleepDay AS Date,
  s.Weekday,
  s.TotalMinutesAsleep,
  s.TotalTimeInBed,
  (s.TotalTimeInBed - s.TotalMinutesAsleep) AS SleepLatency,
  a.TotalSteps,
  a.TotalDistance,
  a.VeryActiveMinutes,
  a.FairlyActiveMinutes,
  a.LightlyActiveMinutes,
  a.SedentaryMinutes,
  a.Calories
FROM `bellabitcasestudy-487716.FitBit.SleepDay` s
LEFT JOIN `bellabitcasestudy-487716.FitBit.dailyActivity` a
ON s.Id = a.Id AND s.SleepDay = a.ActivityDate
ORDER BY s.Id, s.SleepDay;

SELECT
  Weekday,
  ROUND(AVG(TotalTimeInBed - TotalMinutesAsleep),2) AS AvgSleepLatency
FROM `bellabitcasestudy-487716.FitBit.SleepDay`
GROUP BY Weekday
ORDER BY AvgSleepLatency;

SELECT
  CORR(a.TotalSteps, (s.TotalTimeInBed - s.TotalMinutesAsleep)) AS corr_steps_latency,
  CORR(a.VeryActiveMinutes, (s.TotalTimeInBed - s.TotalMinutesAsleep)) AS corr_active_latency,
  CORR(a.Calories, (s.TotalTimeInBed - s.TotalMinutesAsleep)) AS corr_calories_latency
FROM `bellabitcasestudy-487716.FitBit.dailyActivity` a
JOIN `bellabitcasestudy-487716.FitBit.SleepDay` s
  ON a.Id = s.Id AND a.ActivityDate = s.SleepDay;


SELECT
  CASE
    WHEN a.TotalSteps < 5000 THEN 'Sedentary (<5000)'
    WHEN a.TotalSteps BETWEEN 5000 AND 7499 THEN 'Low Active (5000–7499)'
    WHEN a.TotalSteps BETWEEN 7500 AND 9999 THEN 'Somewhat Active (7500–9999)'
    WHEN a.TotalSteps BETWEEN 10000 AND 12499 THEN 'Active (10000–12499)'
    ELSE 'Highly Active (12500+)'
  END AS ActivityLevel,

  AVG(s.TotalTimeInBed - s.TotalMinutesAsleep) AS AvgSleepLatency
FROM `bellabitcasestudy-487716.FitBit.dailyActivity` a
JOIN `bellabitcasestudy-487716.FitBit.SleepDay` s
  ON a.Id = s.Id AND a.ActivityDate = s.SleepDay
GROUP BY ActivityLevel
ORDER BY AvgSleepLatency;


SELECT
  Dayweek,
  ROUND(AVG(TotalSteps),2) AS AvgSteps,
  ROUND(AVG(VeryActiveMinutes),2) AS AvgVAMin
FROM `bellabitcasestudy-487716.FitBit.dailyActivity`
GROUP BY Dayweek
ORDER BY AvgSteps DESC;


