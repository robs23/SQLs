SELECT z.zfinIndex, m.zfinIndex, t.scrap
FROM tbBom bom LEFT JOIN tbZfin z ON z.zfinId = bom.zfinId
	LEFT JOIN tbBomReconciliation br ON br.bomRecId = bom.bomRecId
	LEFT JOIN tbZfin m ON m.zfinId = bom.materialId
	LEFT JOIN 
(SELECT z.zfinIndex,cs.scrap
FROM tbComponentScrap cs LEFT JOIN tbZfin z ON z.zfinId = cs.zfinId
	LEFT JOIN tbScrapReconciliation sr ON sr.scrapReconciliationId = cs.componentScrapId
WHERE cs.scrapReconciliationId = (SELECT TOP(1) scrapReconciliationId FROM tbScrapReconciliation ORDER BY dateAdded DESC)) t ON t.zfinIndex = m.zfinIndex
WHERE bom.bomRecId = (SELECT TOP(1) bomRecId FROM tbBomReconciliation ORDER BY dateAdded DESC) AND m.materialType=2