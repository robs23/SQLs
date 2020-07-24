SELECT mat.zfinIndex as Material, mat.zfinName, zfin.zfinIndex, zfin.zfinName, mainLines.machineName
FROM tbBom bom LEFT JOIN tbZfin zfin ON zfin.zfinId=bom.zfinId LEFT JOIN tbBomReconciliation br ON br.bomRecId=bom.bomRecId LEFT JOIN tbZfin mat ON mat.zfinId=bom.materialId
LEFT JOIN 
(SELECT base.zfinId, xx.machineName FROM tbZfin base OUTER APPLY 
(SELECT	TOP(1) thezfin.zfinId, mach.machineName, SUM(od.plAmount) as amount
FROM tbOperations o LEFT JOIN tbOperationData od ON od.operationId=o.operationId LEFT JOIN tbZfin thezfin ON thezfin.zfinId=o.zfinId LEFT JOIN tbMachine mach ON Mach.machineId=od.plMach
WHERE thezfin.zfinId=base.zfinId AND od.plMoment BETWEEN '2016-01-01' AND '2017-11-20'
GROUP BY thezfin.zfinId, mach.machineName
ORDER BY thezfin.zfinId, amount DESC) xx
WHERE base.zfinType='zfin' AND base.prodStatus='pr') mainLines ON mainLines.zfinId=zfin.zfinId
WHERE mat.materialType=4 AND zfin.prodStatus='pr'
GROUP BY mat.zfinIndex, mat.zfinName, zfin.zfinIndex, zfin.zfinName, mainLines.machineName
ORDER BY Material
