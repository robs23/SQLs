SELECT CASE WHEN DATEPART(ISO_WEEK,ph.moment) < 10 THEN 
	CAST(YEAR(ph.moment) as varchar(4)) + '_0' + CAST(DATEPART(ISO_WEEK,ph.moment) as varchar(1))
ELSE CAST(YEAR(ph.moment) as varchar(4)) + '_' + CAST(DATEPART(ISO_WEEK,ph.moment) as varchar(2)) END  As Okres,
SUM(ph.amountPc * u.unitWeight) as Ilosc
FROM tbProductionHistory ph LEFT JOIN tbZfin z ON z.zfinId=ph.prodId LEFT JOIN tbMachine m ON ph.machId = m.machineId LEFT JOIN tbUom u ON ph.prodId = u.zfinId
WHERE z.zfinIndex = 4009033
GROUP BY CASE WHEN DATEPART(ISO_WEEK,ph.moment) < 10 THEN 
	CAST(YEAR(ph.moment) as varchar(4)) + '_0' + CAST(DATEPART(ISO_WEEK,ph.moment) as varchar(1))
ELSE CAST(YEAR(ph.moment) as varchar(4)) + '_' + CAST(DATEPART(ISO_WEEK,ph.moment) as varchar(2)) END
ORDER BY Okres DESC
