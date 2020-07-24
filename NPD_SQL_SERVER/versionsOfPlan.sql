SELECT DISTINCT ov.operDataVerId, ov.createdOn, 'W' + CAST(DATEPART(ISO_WEEK,ov.createdOn) as varchar) + '_D' + CAST(DATEPART(WEEKDAY,ov.createdOn) as varchar) + '_T' + CAST(DATEPART(HOUR,ov.createdOn) as varchar) + ':' + CAST(DATEPART(MINUTE,ov.createdOn) as varchar) as dayOfWeek, ov.startRange, ov.endRange
FROM tbOperationDataVersions ov LEFT JOIN tbOperationDataHistory oh ON oh.operDataVer=ov.operDataVerId
WHERE oh.plMoment BETWEEN '2017-04-02 14:00:00' AND '2017-04-09 21:00:00'
ORDER BY ov.createdOn DESC

SELECT oh.operDataVer, CAST(COUNT(oh.operationId) as float) / CAST((SELECT COUNT(ohAll.operationId) FROM tbOperationDataHistory ohAll WHERE ohAll.operDataVer=oh.operDataVer AND ohAll.plMoment BETWEEN '2017-04-02 22:00:00' AND '2017-04-19 21:00:00') AS float) as perc
FROM tbOperationDataHistory oh
WHERE oh.plMoment BETWEEN '2017-04-02 22:00:00' AND '2017-04-19 21:00:00'
GROUP BY oh.operDataVer
--HAVING CAST(COUNT(oh.operationId) as float) / CAST((SELECT COUNT(ohAll.operationId) FROM tbOperationDataHistory ohAll WHERE ohAll.operDataVer=oh.operDataVer) AS float) > 0.85

SELECT MIN(od.plMoment)
FROM tbOperationData od
WHERE od.plMoment BETWEEN '2017-04-09 14:00:00' AND '2017-04-16 21:00:00'

SET DATEFIRST 1;
SELECT oh.operDataVer, ov.createdOn, 'W' + CAST(DATEPART(ISO_WEEK,ov.createdOn) as varchar) + '_D' + CAST(DATEPART(WEEKDAY,ov.createdOn) as varchar) + '_T' + CAST(DATEPART(HOUR,ov.createdOn) as varchar) + ':' + CAST(DATEPART(MINUTE,ov.createdOn) as varchar) as dayOfWeek, 
CAST(COUNT(oh.operationId) as float) / CAST((SELECT COUNT(ohAll.operationId) FROM tbOperationData ohAll WHERE ohAll.plMoment BETWEEN '2017-04-09 22:00:00' AND '2017-04-16 21:00:00') AS float) as perc
FROM tbOperationDataHistory oh JOIN tbOperationDataVersions ov ON ov.operDataVerId=oh.operDataVer
WHERE oh.plMoment BETWEEN '2017-04-09 14:00:00' AND '2017-04-16 21:00:00'
GROUP BY oh.operDataVer, ov.createdOn, 'W' + CAST(DATEPART(ISO_WEEK,ov.createdOn) as varchar) + '_D' + CAST(DATEPART(WEEKDAY,ov.createdOn) as varchar) + '_T' + CAST(DATEPART(HOUR,ov.createdOn) as varchar) + ':' + CAST(DATEPART(MINUTE,ov.createdOn) as varchar)
HAVING CAST(COUNT(oh.operationId) as float) / CAST((SELECT COUNT(ohAll.operationId) FROM tbOperationData ohAll WHERE ohAll.plMoment BETWEEN '2017-04-09 22:00:00' AND '2017-04-16 21:00:00') AS float) > 0.8
ORDER BY ov.createdOn