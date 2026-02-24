SELECT  
COUNT(Id)
FROM `bellabitcasestudy-487716.FitBit.dailyActivity` 
WHERE TotalSteps=0 AND TotalDistance = 0 AND TrackerDistance = 0 AND LightActiveDistance=0 AND  ModeratelyActiveDistance=0 AND VeryActiveDistance=0 AND LoggedActivitiesDistance=0;



SELECT  
Id,
Dayweek,
COUNT (Dayweek)
FROM `bellabitcasestudy-487716.FitBit.dailyActivity` 
WHERE TotalSteps=0 AND TotalDistance = 0 AND TrackerDistance = 0 AND LightActiveDistance=0 AND  ModeratelyActiveDistance=0 AND VeryActiveDistance=0 AND LoggedActivitiesDistance=0
GROUP BY Id, Dayweek;

SELECT  
  Dayweek,
  COUNT(*) AS TotalDaysOff
FROM `bellabitcasestudy-487716.FitBit.dailyActivity`
WHERE 
  TotalSteps = 0 
  AND TotalDistance = 0 
  AND TrackerDistance = 0 
  AND LightActiveDistance = 0 
  AND ModeratelyActiveDistance = 0 
  AND VeryActiveDistance = 0 
  AND LoggedActivitiesDistance = 0
GROUP BY Dayweek
ORDER BY TotalDaysOff DESC;
