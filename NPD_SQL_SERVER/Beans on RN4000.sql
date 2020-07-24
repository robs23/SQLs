SELECT MAX(od.plMoment) as lastProduction, z.zfinIndex
FROM tbOperations o LEFT JOIN tbOperationData od ON od.operationId=o.operationId LEFT JOIN tbZfin z ON z.zfinId=o.zfinId LEFT JOIN tbZfinProperties zp ON zp.zfinId=z.zfinId LEFT JOIN tbMachine m ON m.machineId=od.plMach
WHERE o.type='r' AND (zp.[beans?]=1 OR zp.[beans?]=-1) AND m.machineName='RN4000'
GROUP BY z.zfinIndex
