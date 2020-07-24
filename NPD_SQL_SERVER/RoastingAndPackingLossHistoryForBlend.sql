SELECT CAST(bm.bmYear as char(4)) + '_' + CASE WHEN bm.bmWeek < 10 THEN '0'+ CAST(bm.bmWeek as char(2)) ELSE CAST(bm.bmWeek as char(2)) END as Period, bmo.roastingOut - bmo.roastingIn as [Roasting Loss in KG],
((bmo.roastingOut - bmo.roastingIn)/bmo.roastingIn) * 100 as [Roasting Loss in %],
bmo.packingIn - bmo.roastingOut as [Grinding Loss in KG],
((bmo.packingIn - bmo.roastingOut)/bmo.roastingOut)*100 as [Grinding Loss in %],
bmo.packingOut - bmo.packingIn as [Packing Loss in KG],
((bmo.packingOut - bmo.packingIn)/bmo.packingIn)*100 as [Packing Loss in %],
bmo.warehouseIn - bmo.roastingOut as [G+P Loss in KG],
((bmo.warehouseIn - bmo.roastingOut)/bmo.roastingOut)*100 as [G+P Loss in %],
bmo.warehouseIn - bmo.roastingIn as [Total Loss in KG],
((bmo.warehouseIn - bmo.roastingIn)/bmo.roastingIn)*100 as [Total Loss in %],
bmo.rework as [Rework],
bmo.bomVsRealScrap*100 as [BOM vs REAL],
bmo.isConsistent
FROM tbZfin z 
LEFT JOIN tbBMOverview bmo ON bmo.zfinId = z.zfinId
LEFT JOIN tbBM bm ON bm.bmId = bmo.bmId
WHERE z.zfinIndex=37606002 AND bm.bmWeek IS NOT NULL
ORDER BY Period