SELECT comp.zfinIndex as component, comp.zfinName as comp_name, comp.basicUom, pc.actualConsumption, pc.actualScrap, o.sapId
FROM tbProductionConsumption pc LEFT JOIN tbOrders o ON o.orderId=pc.orderId LEFT JOIN tbZfin comp ON comp.zfinId=pc.componentId 
WHERE o.sapId IN (12014083) AND comp.materialType=2 
