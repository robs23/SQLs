SELECT conScrap.*, freshScrap.dateAdded, z.zfinType, z.zfinIndex, z.zfinName
FROM tbComponentScrap conScrap LEFT JOIN tbZfin z ON z.zfinId=conScrap.zfinId RIGHT JOIN
(SELECT oScrap.zfinId,  MAX(oScrap.scrapReconciliationId) as scrapRecId, MAX(oScrap.dateAdded) as dateAdded FROM
(SELECT iScrap.scrapReconciliationId, zfinId, sr.dateAdded FROM tbScrapReconciliation sr JOIN (
SELECT scrapReconciliationId, cs.zfinId
FROM tbComponentScrap cs
GROUP BY scrapReconciliationId, cs.zfinId) iScrap ON iScrap.scrapReconciliationId=sr.scrapReconciliationId) oScrap
WHERE oScrap.dateAdded <='2017-12-21 00:00:00.000'
GROUP BY oScrap.zfinId) freshScrap ON freshScrap.zfinId=conScrap.zfinId AND freshScrap.scrapRecId=conScrap.scrapReconciliationId 
WHERE z.zfinType='zfor'