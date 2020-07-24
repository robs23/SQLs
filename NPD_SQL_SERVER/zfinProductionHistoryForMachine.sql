SELECT zfinIndex FROM tbZfin zz 
SELECT TOP(1) z.zfinId, machineName, ROUND(SUM(od.plAmount)/
(SELECT SUM(od.plAmount) as Total
FROM tbOperations o LEFT JOIN tbOperationData od ON od.operationId=o.operationId LEFT JOIN tbZfin z ON z.zfinId=o.zfinId
WHERE z.zfinId=97 AND od.plMoment BETWEEN '2016-11-20' AND '2017-11-20')*100,1) as share
FROM tbOperations o LEFT JOIN tbOperationData od ON od.operationId=o.operationId LEFT JOIN tbZfin z ON z.zfinId=o.zfinId LEFT JOIN tbMachine mach ON mach.machineId=od.plMach
WHERE z.zfinId=97 AND od.plMoment BETWEEN '2016-11-20' AND '2017-11-20'
GROUP BY z.zfinId,mach.machineName
ORDER BY share DESC
