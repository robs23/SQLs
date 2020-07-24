USE npd

SELECT m.machineName, (m.Amount/m.Total)*100 AS ProductionStats FROM 
(SELECT m.machineName, SUM(od.plAmount) AS Amount,
	(
	SELECT SUM(od.plAmount) 
	FROM tbOperationData od
	LEFT JOIN tbOperations op ON op.operationId=od.operationId
	LEFT JOIN tbZfin z ON z.zfinId=op.zfinId
	WHERE od.plMoment > '2020-02-01'  AND od.plMoment < '2020-02-06' AND z.zfinIndex=34005471 AND type='r'
	) as Total
FROM
tbOperationData od
LEFT JOIN tbOperations op ON op.operationId=od.operationId
LEFT JOIN tbZfin z ON z.zfinId=op.zfinId
LEFT JOIN tbMachine m ON m.machineId=od.plMach
WHERE od.plMoment > '2020-02-01'  AND od.plMoment < '2020-02-06' AND z.zfinIndex=34005471 AND type='r'
GROUP BY m.machineName, type)m
ORDER BY m.Amount DESC