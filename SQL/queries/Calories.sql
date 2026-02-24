
SELECT
  Weekday,
  ROUND(AVG(Calories),2) AS AvgCalories
FROM `bellabitcasestudy-487716.FitBit.dailyCalories`
GROUP BY Weekday
ORDER BY AvgCalories;



SELECT
  EXTRACT(HOUR FROM Time) AS HourOfDay,
  ROUND(AVG(Calories), 2) AS AvgCalories
FROM `bellabitcasestudy-487716.FitBit.hourlyCalories`
GROUP BY HourOfDay
ORDER BY HourOfDay;


SELECT
  Id,
  ROUND(AVG(Calories), 2) AS AvgCalories,
  MIN(Calories) AS MinCalories,
  MAX(Calories) AS MaxCalories,
  COUNT(*) AS RecordsCount
FROM `bellabitcasestudy-487716.FitBit.hourlyCalories`
GROUP BY Id
ORDER BY AvgCalories DESC;
