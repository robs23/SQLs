SELECT z.zfinIndex, z.zfinName, bom.amount, bom.unit, MAX(br.dateAdded) as dateAdded
FROM tbBom bom LEFT JOIN tbZfin z ON z.zfinId=bom.zfinId LEFT JOIN tbBomReconciliation br ON br.bomRecId=bom.bomRecId
WHERE bom.materialId=613
GROUP BY z.zfinIndex, z.zfinName, bom.amount, bom.unit