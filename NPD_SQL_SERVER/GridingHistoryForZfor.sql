SELECT z.zfinIndex, m.machineName, od.plMoment 
FROM tbZfin z LEFT JOIN tbOperations o ON o.zfinId=z.zfinId LEFT JOIN tbOperationData od ON od.operationId=o.operationId 
LEFT JOIN tbMachine m ON m.machineId=od.plMach
WHERE z.zfinIndex=34103160 AND o.type='g'
ORDER BY od.plMoment DESC