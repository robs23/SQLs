SELECT oBom.zfinId, MAX(oBom.bomRecId) as bomRecId, MAX(oBom.dateAdded) as dateAdded FROM
(SELECT iBom.*, br.dateAdded FROM tbBomReconciliation br JOIN (
SELECT zfinId, bomRecId
FROM tbBom bom 
GROUP BY bomRecId, zfinId) iBom ON iBom.bomRecId=br.bomRecId) oBom
WHERE oBom.dateAdded <='2017-10-25 15:00:00.000'
GROUP BY oBom.zfinId
ORDER BY oBom.zfinId