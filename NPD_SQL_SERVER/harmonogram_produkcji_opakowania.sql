DECLARE @dateFrom datetime,
		@dateTo datetime
SET @dateFrom = '2017-10-29 22:00:00'
SET @dateTo = '2017-11-05 21:00:00'

SELECT o.mesId, theBom.bomRecId, o.zfinId, o.mesString, theBom.materialId, mat.zfinIndex, mat.zfinName, mat.zfinType, od.plMoment,od.plShift, m.machineName as Maszyna, (od.plAmount/theBom.pcPerPallet) * theBom.amount as matAmount, theBom.unit, CASE WHEN matType.materialTypeName IS NULL THEN 'Nieznany' ELSE matType.materialTypeName END as MaterialType,zp.[beans?] as bean,zp.[decafe?] as decaf, 'Wszystkie' as brak, zfin.zfinIndex as iZfin
FROM tbOperations o LEFT JOIN tbOperationData od ON od.operationId=o.operationId LEFT JOIN tbMachine m ON m.machineId=od.plMach LEFT JOIN tbZfin zfin ON zfin.zfinId=o.zfinId LEFT JOIN 
(SELECT bomy.*, freshBom.dateAdded, (u.unitWeight*u.pcPerPallet) as KG_PAL, u.pcPerPallet FROM tbBom bomy RIGHT JOIN
(SELECT oBom.zfinId,  MAX(oBom.bomRecId) as bomRecId, MAX(oBom.dateAdded) as dateAdded FROM
(SELECT iBom.bomRecId, zfinId, br.dateAdded FROM tbBomReconciliation br JOIN (
SELECT bomRecId, zfinId
FROM tbBom bom 
GROUP BY bomRecId, zfinId) iBom ON iBom.bomRecId=br.bomRecId) oBom
WHERE oBom.dateAdded <=@dateTo
GROUP BY oBom.zfinId) freshBom ON freshBom.zfinId=bomy.zfinId AND freshBom.bomRecId=bomy.bomRecId 
LEFT JOIN tbUom u ON u.zfinId=bomy.zfinId) theBom ON theBom.zfinId=o.zfinId LEFT JOIN tbZfin mat ON mat.zfinId=theBom.materialId LEFT JOIN tbMaterialType matType ON mat.materialType=matType.materialTypeId 
LEFT JOIN tbZfinProperties zp ON zp.zfinId=o.zfinId
WHERE od.plMoment >= @dateFrom AND od.plMoment < @dateTo AND o.type = 'p' AND mat.zfinType = 'zpkg'
ORDER BY Maszyna DESC, plMoment ASC

