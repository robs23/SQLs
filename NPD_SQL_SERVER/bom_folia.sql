SELECT CASE WHEN EXISTS
(SELECT bomy.amount, bomy.unit FROM tbBom bomy RIGHT JOIN
(SELECT oBom.zfinId,  MAX(oBom.bomRecId) as bomRecId, MAX(oBom.dateAdded) as dateAdded FROM
(SELECT iBom.bomRecId, zfinId, br.dateAdded FROM tbBomReconciliation br JOIN (
SELECT bomRecId, bom.zfinId
FROM tbBom bom
GROUP BY bomRecId, bom.zfinId) iBom ON iBom.bomRecId=br.bomRecId) oBom
WHERE oBom.dateAdded <='2018-06-30 00:00:00.000'
GROUP BY oBom.zfinId) freshBom ON freshBom.zfinId=bomy.zfinId AND freshBom.bomRecId=bomy.bomRecId 
LEFT JOIN tbZfin zfin ON zfin.zfinId=bomy.zfinId LEFT JOIN tbZfin mat ON mat.zfinId=bomy.materialId 
WHERE mat.materialType=2 AND zfin.zfinIndex=4051087)
THEN 
(SELECT bomy.amount FROM tbBom bomy RIGHT JOIN
(SELECT oBom.zfinId,  MAX(oBom.bomRecId) as bomRecId, MAX(oBom.dateAdded) as dateAdded FROM
(SELECT iBom.bomRecId, zfinId, br.dateAdded FROM tbBomReconciliation br JOIN (
SELECT bomRecId, bom.zfinId
FROM tbBom bom
GROUP BY bomRecId, bom.zfinId) iBom ON iBom.bomRecId=br.bomRecId) oBom
WHERE oBom.dateAdded <='2018-07-30 00:00:00.000'
GROUP BY oBom.zfinId) freshBom ON freshBom.zfinId=bomy.zfinId AND freshBom.bomRecId=bomy.bomRecId 
LEFT JOIN tbZfin zfin ON zfin.zfinId=bomy.zfinId LEFT JOIN tbZfin mat ON mat.zfinId=bomy.materialId 
WHERE mat.materialType=2 AND zfin.zfinIndex=4051087)
ELSE 'Empty'
END As Result