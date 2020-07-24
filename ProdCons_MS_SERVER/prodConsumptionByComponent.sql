SELECT comp.zfinId, comp.zfinIndex as component, comp.zfinName as comp_name, comp.basicUom, SUM(pc.targetConsumption-pc.actualConsumption) as [Loss in pc],
SUM(pc.targetConsumption-pc.actualConsumption)*
(SELECT c.cost/c.CostLotSize
FROM tbCosting c
WHERE c.reconciliationId = (SELECT TOP(1) cr.CostingReconciliationId FROM tbCostingReconciliation cr ORDER BY cr.dateAdded DESC) AND c.zfinId=comp.zfinId) as [Loss in €]
FROM tbProductionConsumption pc LEFT JOIN tbZfin comp ON comp.zfinId=pc.componentId LEFT JOIN tbOrders o ON o.orderId=pc.orderId
LEFT JOIN tbZfin z ON z.zfinId=o.zfinId
WHERE comp.zfinIndex=10015636 AND comp.zfinType='zpkg' AND pc.actualConsumption > 0 
GROUP BY comp.zfinId, comp.zfinIndex, comp.zfinName, comp.basicUom
