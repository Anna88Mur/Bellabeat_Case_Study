WITH per_user AS (
  SELECT
    Id,
    AVG(TotalSteps) AS AvgSteps
  FROM `bellabitcasestudy-487716.FitBit.dailyActivity`
  GROUP BY Id
)
SELECT
  CASE
    WHEN AvgSteps < 5000 THEN 'Sedentary (<5000)'
    WHEN AvgSteps BETWEEN 5000 AND 7499 THEN 'Low Active (5000–7499)'
    WHEN AvgSteps BETWEEN 7500 AND 9999 THEN 'Somewhat Active (7500–9999)'
    WHEN AvgSteps BETWEEN 10000 AND 12499 THEN 'Active (10000–12499)'
    ELSE 'Highly Active (12500+)'
  END AS ActivityLevel,
  COUNT(*) AS UsersCount
FROM per_user
GROUP BY ActivityLevel
ORDER BY UsersCount DESC;
