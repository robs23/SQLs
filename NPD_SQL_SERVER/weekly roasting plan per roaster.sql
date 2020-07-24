DECLARE @sDate as datetime; 
DECLARE @eDate as datetime; 
SELECT @sDate = '2018-01-14 14:00:00'; 
SELECT @eDate='2018-01-21 06:00:00'; 
WITH sample AS ( SELECT CAST(@sDate AS DATETIME) AS dt 
Union ALL SELECT DATEADD(HH, 8, dt) FROM sample s 
WHERE DATEADD(HH, 8, dt) <= CAST(@eDate AS DATETIME)) SELECT sample.dt, 
CONVERT(date,sample.dt,103) as Data, DATEPART(weekday,CONVERT(date,sample.dt,103)) as Weekday, 
CASE WHEN DATEPART(hh,sample.dt)=6 THEN 1 ELSE CASE WHEN DATEPART(hh,sample.dt)=14 THEN 2 ELSE 3 END END as [Zmiana], 
(SELECT SUM(od.plAmount) as plAmount FROM tbOperationData od LEFT JOIN tbOperations o ON o.operationId=od.operationId WHERE sample.dt=od.plMoment AND o.type='r' AND od.plMach=13) as RN3000, 
(SELECT SUM(od.plAmount) as plAmount FROM tbOperationData od LEFT JOIN tbOperations o ON o.operationId=od.operationId WHERE sample.dt=od.plMoment AND o.type='r' AND od.plMach=14) as RN4000 FROM sample
