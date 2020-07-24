SELECT bomy.*, freshBom.dateAdded FROM tbBom bomy RIGHT JOIN
(SELECT oBom.zfinId,  MAX(oBom.bomRecId) as bomRecId, MAX(oBom.dateAdded) as dateAdded FROM
(SELECT iBom.bomRecId, zfinId, br.dateAdded FROM tbBomReconciliation br JOIN (
SELECT bomRecId, bom.zfinId
FROM tbBom bom
GROUP BY bomRecId, bom.zfinId) iBom ON iBom.bomRecId=br.bomRecId) oBom
WHERE oBom.dateAdded <='2017-11-04 00:00:00.000'
GROUP BY oBom.zfinId) freshBom ON freshBom.zfinId=bomy.zfinId AND freshBom.bomRecId=bomy.bomRecId 
LEFT JOIN tbUom u ON u.zfinId=bomy.zfinId LEFT JOIN tbZfin zfin ON zfin.zfinId=bomy.materialId 
WHERE zfin.materialType=2