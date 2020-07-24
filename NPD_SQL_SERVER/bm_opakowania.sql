SELECT z.zfinIndex as [Material], z.zfinName as [Material Name], COUNT(o.sapId) as [Number of orders], SUM(pc.actualConsumption) as [Actual Consumption], SUM(o.plannedSap) as [0-based Consumption], SUM(o.plannedSap)-SUM(pc.actualConsumption) as [Loss (pc)], ROUND(((SUM(o.plannedSap)-SUM(pc.actualConsumption))/SUM(o.plannedSap))*100,1) as [Loss (%)]
FROM tbProductionConsumption pc LEFT JOIN tbZfin z ON z.zfinId=pc.componentId LEFT JOIN tbOrders o ON o.orderId=pc.orderId
WHERE z.zfinType <> 'zfin' AND z.materialType =2 AND z.basicUom = 'PC'
GROUP BY z.zfinIndex,z.zfinName
ORDER BY [Loss (%)]