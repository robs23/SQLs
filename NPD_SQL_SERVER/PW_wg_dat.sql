SELECT SUM(qd.batchSize*u1.unitWeight) 
FROM tbQdocData qd INNER JOIN tbQdocReconciliation qr on qr.qReconciliationId=qd.qReconciliationId INNER JOIN tbBatch b ON b.batchId=qd.batchId INNER JOIN tbUom u1 ON u1.zfinId=b.zfinId 
WHERE qr.qType='WHD_PW' AND qr.qDate BETWEEN '2017-01-01' AND '2017-06-30'