DECLARE @sDate as datetime;
DECLARE @eDate as datetime;
SELECT @sDate = '2017-09-17';
SELECT @eDate='2017-09-24';
SELECT CONVERT(date,od.plMoment,103) as Data, DATEPART(weekday,CONVERT(date,od.plMoment,103)) as Weekday, CASE WHEN DATEPART(hh,od.plMoment)=6 THEN 1 ELSE CASE WHEN DATEPART(hh,od.plMoment)=14 THEN 2 ELSE 3 END END as [Zmiana], SUM(od.plAmount) as [KG]
FROM tbOperations o LEFT JOIN tbOperationData od ON od.operationId=o.operationId
WHERE od.plMoment BETWEEN @sDate AND @eDate AND o.type='g'
GROUP BY CONVERT(date,od.plMoment,103),DATEPART(weekday,CONVERT(date,od.plMoment,103)), CASE WHEN DATEPART(hh,od.plMoment)=6 THEN 1 ELSE CASE WHEN DATEPART(hh,od.plMoment)=14 THEN 2 ELSE 3 END END
ORDER BY Weekday, Zmiana ASC