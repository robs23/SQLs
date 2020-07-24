SELECT SUM(bomy.amount) as TotalKg,ROUND(((SUM(bomy.amount)-1000)/SUM(bomy.amount))*100,2) as RandGScrap, mainZfin.zfinIndex, mainZfin.zfinName, freshBom.dateAdded
FROM tbBom bomy RIGHT JOIN
(SELECT oBom.zfinId,  MAX(oBom.bomRecId) as bomRecId, MAX(oBom.dateAdded) as dateAdded FROM
(SELECT iBom.bomRecId, zfinId, br.dateAdded FROM tbBomReconciliation br JOIN (
SELECT bomRecId, bom.zfinId
FROM tbBom bom
GROUP BY bomRecId, bom.zfinId) iBom ON iBom.bomRecId=br.bomRecId) oBom
WHERE oBom.dateAdded <='2017-12-21 00:00:00.000'
GROUP BY oBom.zfinId) freshBom ON freshBom.zfinId=bomy.zfinId AND freshBom.bomRecId=bomy.bomRecId 
LEFT JOIN tbUom u ON u.zfinId=bomy.zfinId LEFT JOIN tbZfin zfin ON zfin.zfinId=bomy.materialId 
LEFT JOIN tbZfin mainZfin ON mainZfin.zfinId=bomy.zfinId LEFT JOIN tbZfin zcom ON zcom.zfinId=bomy.materialId
WHERE bomy.zfinId IN 
(SELECT zfor.zfinId
FROM tbZfin zfor
WHERE zfor.zfinType='zfor' AND zfor.prodStatus<>'OB' AND zfor.prodStatus<>'HI')
GROUP BY mainZfin.zfinIndex, mainZfin.zfinName, freshBom.dateAdded