SELECT z.zfinIndex, z.zfinName, z.prodStatus, c.cost, c.CostLotSize, c.CostLotSizeUnit
FROM tbZfin z LEFT JOIN tbCosting c ON c.zfinId=z.zfinId
WHERE z.zfinType = 'zfor' AND c.reconciliationId = (SELECT TOP(1) cs.CostingReconciliationId FROM tbCostingReconciliation cs ORDER BY cs.addedBy DESC)
ORDER BY cost DESC