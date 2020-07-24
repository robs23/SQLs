USE npd
SELECT z.zfinIndex, z.zfinName,
AVG((bmo.roastingOut - bmo.roastingIn)/NULLIF(bmo.roastingIn,0)) * 100 as [Roasting Loss in %],
AVG((bmo.packingIn - (bmo.roastingOut+bmo.rework))/(NULLIF(bmo.roastingOut,0)+bmo.rework))*100 as [Grinding Loss in %],
AVG((bmo.packingOut - (bmo.packingIn+ISNULL(bmo.reworkAtPacking,0)))/(NULLIF(bmo.packingIn,0)+ISNULL(bmo.reworkAtPacking,0)))*100 as [Packing Loss in %],
AVG((bmo.warehouseIn - (bmo.roastingOut+bmo.rework+ISNULL(bmo.reworkAtPacking,0)))/(NULLIF(bmo.roastingOut,0)+bmo.rework+ISNULL(bmo.reworkAtPacking,0)))*100 as [G+P Loss in %],
AVG((bmo.warehouseIn - (bmo.roastingIn+bmo.rework + ISNULL(bmo.reworkAtPacking,0)))/(NULLIF(bmo.roastingIn,0)+bmo.rework + ISNULL(bmo.reworkAtPacking,0)))*100 as [Total Loss in %],
AVG(bmo.rework) as [Rework],
AVG(bmo.bomVsRealScrap)*100 as [BOM vs REAL]
FROM tbZfin z 
LEFT JOIN tbBMOverview bmo ON bmo.zfinId = z.zfinId
LEFT JOIN tbBM bm ON bm.bmId = bmo.bmId
WHERE bm.bmWeek IS NOT NULL AND bm.bmWeek > 19 AND bm.bmYear >= 2019 AND bmo.isConsistent = 1
GROUP BY z.zfinIndex, z.zfinName

