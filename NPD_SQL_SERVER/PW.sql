SELECT DISTINCT o1.sapId as id, z.zfinIndex as zfin, z.zfinName as name,o1.executedSap*u.unitWeight as kg, b.batchNumber as batch, SUM(q.batchSize*u.unitWeight) as pw
FROM tbOrders o LEFT JOIN tbOrderDep od ON od.zforOrder=o.orderId LEFT JOIN tbOrders o1 ON o1.orderId = od.zfinOrder LEFT JOIN tbZfin z ON z.zfinId = o1.zfinId LEFT JOIN tbUom u ON u.zfinId = z.zfinId LEFT JOIN tbBatch b ON b.batchId=o1.batchId
	LEFT JOIN tbQdocData q ON q.batchId= o1.batchId LEFT JOIN tbQdocReconciliation qr ON qr.qReconciliationId=q.qReconciliationId
WHERE o.sapId IN (11822988,11822989,11823437,11823438) AND qr.qType = 'WHD_PW'
GROUP BY o1.sapId, z.zfinIndex, z.zfinName,o1.executedSap*u.unitWeight, b.batchNumber
