SELECT o.sapId, comp.zfinIndex as component, comp.zfinName as comp_name, comp.basicUom, pc.actualConsumption,pc.actualScrap,pc.targetScrap, z.zfinIndex, z.zfinName
FROM tbProductionConsumption pc LEFT JOIN tbZfin comp ON comp.zfinId=pc.componentId LEFT JOIN tbOrders o ON o.orderId=pc.orderId
LEFT JOIN tbZfin z ON z.zfinId=o.zfinId 
WHERE pc.actualConsumption IS NOT NULL AND pc.actualConsumption > 0 AND o.sapId IN (12014083,
12020380,
12020380,
12014083,
12025695,
12017359
) AND comp.materialType=2