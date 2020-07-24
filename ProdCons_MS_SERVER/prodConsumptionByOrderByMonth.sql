SELECT * 
FROM (
	SELECT o.orderId, z.zfinIndex, o.sapId, comp.basicUom, o.plannedSap, pc.actualConsumption,pc.targetConsumption, pc.targetScrap, pc.targetConsumption-pc.actualConsumption as [Lost/gained],
	pc.actualScrap,
	(pc.targetConsumption-pc.actualConsumption)*(SELECT c.cost/c.CostLotSize
	FROM tbCosting c
	WHERE c.reconciliationId = (SELECT TOP(1) cr.CostingReconciliationId FROM tbCostingReconciliation cr ORDER BY cr.dateAdded DESC) AND c.zfinId=comp.zfinId) as [Lost/gained value],
	(SELECT TOP(1) CONVERT(nvarchar(4),YEAR(od.plMoment)) + '_' + CASE WHEN(CONVERT(nvarchar(2),MONTH(od.plMoment))<10) THEN '0' + CONVERT(nvarchar(2),MONTH(od.plMoment)) ELSE CONVERT(nvarchar(2),MONTH(od.plMoment)) END as p
	FROM tbOperations op LEFT JOIN (SELECT * FROM tbOperationData WHERE plMoment >= '2017-11-01' AND plMoment <= '2018-12-30') od ON od.operationId=op.operationId
	WHERE op.orderId=o.orderId
	ORDER BY p DESC) as [Produced in month]
	FROM tbProductionConsumption pc LEFT JOIN tbZfin comp ON comp.zfinId=pc.componentId LEFT JOIN tbOrders o ON o.orderId=pc.orderId
	LEFT JOIN tbZfin z ON z.zfinId=o.zfinId 
	WHERE comp.zfinIndex=10015643	AND pc.actualConsumption > 0
) a
WHERE a.[Produced in month] IS NOT NULL
ORDER BY a.[Produced in month]
	
