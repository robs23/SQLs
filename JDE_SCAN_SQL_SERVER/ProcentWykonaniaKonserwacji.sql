USE JDE_Scan_prod
SELECT DATEPART(ISO_WEEK, p.PlannedFinish) as [Tydzieñ], YEAR(p.PlannedFinish) as [Rok],
	SUM(CASE WHEN pa.IsChecked=1 THEN 1 ELSE 0 END)  as [Wykonane], COUNT(pa.ActionId) as [Wszystkie],
	(CAST(SUM(CASE WHEN pa.IsChecked=1 THEN 1 ELSE 0 END) as float) /CAST(COUNT(pa.ActionId) as float))*100 as [Procent]
FROM JDE_Processes p
	LEFT JOIN JDE_ProcessActions pa ON pa.ProcessId = p.ProcessId
WHERE YEAR(p.PlannedFinish) >=2020 AND DATEPART(ISO_WEEK, p.PlannedFinish) >=3 AND p.PlannedStart IS NOT NULL
GROUP BY DATEPART(ISO_WEEK, p.PlannedFinish), YEAR(p.PlannedFinish)
ORDER BY Rok, Tydzieñ
