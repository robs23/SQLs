SELECT COUNT(a.orderId) as [Number of orders], a.component, a.comp_name, a.basicUom, SUM(a.[Lost/gained]) as [Lost/Gained], SUM(a.[Lost/gained value]) as [Lost/gained value], a.[Produced in month]
FROM (
	SELECT o.orderId, o.sapId, comp.zfinIndex as component, comp.zfinName as comp_name, comp.basicUom, pc.targetConsumption-pc.actualConsumption as [Lost/gained],
	(pc.targetConsumption-pc.actualConsumption)*(SELECT c.cost/c.CostLotSize
	FROM tbCosting c
	WHERE c.reconciliationId = (SELECT TOP(1) cr.CostingReconciliationId FROM tbCostingReconciliation cr ORDER BY cr.dateAdded DESC) AND c.zfinId=comp.zfinId) as [Lost/gained value],
	(SELECT TOP(1) CONVERT(nvarchar(4),YEAR(od.plMoment)) + '_' + CONVERT(nvarchar(2),MONTH(od.plMoment)) as p
	FROM tbOperations op LEFT JOIN tbOperationData od ON od.operationId=op.operationId
	WHERE op.orderId=o.orderId
	ORDER BY p DESC) as [Produced in month]
	FROM tbProductionConsumption pc LEFT JOIN tbZfin comp ON comp.zfinId=pc.componentId LEFT JOIN tbOrders o ON o.orderId=pc.orderId
	LEFT JOIN tbZfin z ON z.zfinId=o.zfinId 
	WHERE comp.zfinIndex=10007461 AND comp.zfinType='zpkg' AND pc.actualConsumption > 0
) a
GROUP BY a.component, a.comp_name, a.basicUom, a.[Produced in month]