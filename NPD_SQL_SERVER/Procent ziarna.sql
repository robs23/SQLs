SELECT CONVERT(nchar(4),YEAR(swarm.qDate)) + '/' + CONVERT(varchar,MONTH(swarm.qDate)) as Miesi¹c, SUM(swarm.production) as [Ca³kowita produkcja (tony)], SUM(CASE WHEN swarm.[beans?]=1 THEN swarm.production ELSE 0 END) as [Tylko ziarno (tony)], (SUM(CASE WHEN swarm.[beans?]=1 THEN swarm.production ELSE 0 END) / SUM(swarm.production))*100 as [Procent ziarna]
FROM
(SELECT qr.qDate, ((qd.batchSize*u.unitWeight)/1000) as production, zp.[beans?]
FROM tbQdocReconciliation qr LEFT JOIN tbQdocData qd ON qr.qReconciliationId=qd.qReconciliationId LEFT JOIN tbBatch b ON b.batchId=qd.batchId LEFT JOIN tbZfin z ON z.zfinId=b.zfinId LEFT JOIN tbZfinProperties zp ON zp.zfinId=z.zfinId LEFT JOIN tbUom u ON u.zfinId=z.zfinId
WHERE qr.qType='WHD_PW' AND z.zfinType='zfin') swarm
GROUP BY CONVERT(nchar(4),YEAR(swarm.qDate)) + '/' + CONVERT(varchar,MONTH(swarm.qDate))
ORDER BY Miesi¹c
