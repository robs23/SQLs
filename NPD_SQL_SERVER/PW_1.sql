SELECT DISTINCT o1.sapId as id, z.zfinIndex as zfin, z.zfinName as name,o1.executedSap*u.unitWeight as kg, b.batchNumber as batch,
(SELECT SUM(qd.batchSize*u1.unitWeight) FROM tbQdocData qd INNER JOIN tbQdocReconciliation qr on qr.qReconciliationId=qd.qReconciliationId INNER JOIN tbUom u1 ON u1.zfinId=b.zfinId WHERE qr.qType='WHD_PW' AND qd.batchId=b.batchId) as PW
FROM tbOrders o LEFT JOIN tbOrderDep od ON od.zforOrder=o.orderId 
LEFT JOIN tbOrders o1 ON o1.orderId = od.zfinOrder 
LEFT JOIN tbZfin z ON z.zfinId = o1.zfinId 
LEFT JOIN tbUom u ON u.zfinId = z.zfinId 
LEFT JOIN tbBatch b ON b.batchId=o1.batchId
WHERE o.sapId IN (11822810)
GROUP BY o1.sapId, z.zfinIndex, z.zfinName,o1.executedSap*u.unitWeight, b.batchNumber,b.batchId,b.zfinId
