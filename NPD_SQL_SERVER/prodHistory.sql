SELECT SUM(ph.amountPc * u.unitWeight) as Iloœæ, 
CASE WHEN MONTH(ph.moment) < 10 THEN 
	CAST(YEAR(ph.moment) as varchar(4)) + '_0' + CAST(MONTH(ph.moment) as varchar(1))
ELSE CAST(YEAR(ph.moment) as varchar(4)) + '_' + CAST(MONTH(ph.moment) as varchar(2)) END  As Okres
FROM tbProductionHistory ph LEFT JOIN tbZfin z ON z.zfinId=ph.prodId LEFT JOIN tbMachine m ON ph.machId = m.machineId LEFT JOIN tbUom u ON ph.prodId = u.zfinId
WHERE z.zfinIndex = 36499
GROUP BY CASE WHEN MONTH(ph.moment) < 10 THEN CAST(YEAR(ph.moment) as varchar(4)) + '_0' + CAST(MONTH(ph.moment) as varchar(1))
	ELSE CAST(YEAR(ph.moment) as varchar(4)) + '_' + CAST(MONTH(ph.moment) as varchar(2)) END
ORDER BY Okres DESC
