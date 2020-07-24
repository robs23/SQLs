DECLARE @index int
SET @index = 4009033

SELECT zfin.zfinIndex, comp.zfinIndex, comp.zfinName, bom.amount, bom.unit, comp.zfinType, mt.materialTypeName
FROM tbZfin zfin LEFT JOIN tbBom bom ON bom.zfinId=zfin.zfinId LEFT JOIN tbZfin comp ON comp.zfinId=bom.materialId LEFT JOIN tbMaterialType mt ON mt.materialTypeId=comp.materialType
WHERE zfin.zfinIndex=@index AND bom.bomRecId=(SELECT TOP(1) br.bomRecId FROM tbBomReconciliation br LEFT JOIN tbBom bm ON bm.bomRecId=br.bomRecId LEFT JOIN tbZfin z ON z.zfinId=bm.zfinId WHERE z.zfinIndex=@index ORDER BY br.dateAdded DESC)