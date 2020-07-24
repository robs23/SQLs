
SELECT base.zfinId, xx.machineName FROM tbZfin base OUTER APPLY 
(SELECT	TOP(1) thezfin.zfinId, mach.machineName, SUM(od.plAmount) as amount
FROM tbOperations o LEFT JOIN tbOperationData od ON od.operationId=o.operationId LEFT JOIN tbZfin thezfin ON thezfin.zfinId=o.zfinId LEFT JOIN tbMachine mach ON Mach.machineId=od.plMach
WHERE thezfin.zfinId=base.zfinId AND od.plMoment BETWEEN '2016-11-20' AND '2017-11-20'
GROUP BY thezfin.zfinId, mach.machineName
ORDER BY thezfin.zfinId, amount DESC) xx
WHERE base.zfinType='zfin' AND base.prodStatus='pr'
