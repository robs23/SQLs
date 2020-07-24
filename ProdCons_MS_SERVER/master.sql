SELECT a.ZPKG as [ZPKG], a.Nazwa as [Nazwa], a.Miesi�c, a.UoM,a.[Order], a.[Rzeczywista strata w %] as [Rzeczywista strata w %],a.[Oczekiwana strata w %] as [Oczekiwana strata w %], a.[Strata / Zysk (vs BOM)] as [Strata / Zysk (vs BOM)], a.actualConsumption as [Rzeczywiste zu�ycie], a.targetConsumption as [Za�o�one zu�ycie]
FROM(
    SELECT comp.zfinIndex as [ZPKG], comp.zfinName as [Nazwa], comp.basicUom as [UoM], o.sapId as [Order], pc.actualScrap as [Rzeczywista strata w %], pc.targetScrap as [Oczekiwana strata w %], pc.targetConsumption - pc.actualConsumption as [Strata / Zysk (vs BOM)], pc.targetConsumption, pc.actualConsumption,
	(SELECT TOP(1) CONVERT(nvarchar(4), YEAR(od.plMoment)) + '_' + CASE WHEN(CONVERT(nvarchar(2),MONTH(od.plMoment))<10) THEN '0' + CONVERT(nvarchar(2),MONTH(od.plMoment)) ELSE CONVERT(nvarchar(2),MONTH(od.plMoment)) END as p
    FROM tbOperations op LEFT JOIN(SELECT * FROM tbOperationData WHERE plMoment >= '2018-05-01' AND plMoment <= '2018-05-31') od ON od.operationId = op.operationId
    WHERE op.orderId = o.orderId
    ORDER BY p DESC) as [Miesi�c]
    FROM tbProductionConsumption pc LEFT JOIN tbZfin comp ON comp.zfinId = pc.componentId LEFT JOIN tbOrders o ON o.orderId = pc.orderId
    LEFT JOIN tbZfin z ON z.zfinId = o.zfinId
    WHERE pc.actualConsumption > 0 AND comp.materialType=2
) a
WHERE a.[Miesi�c] IS NOT NULL
ORDER BY a.ZPKG