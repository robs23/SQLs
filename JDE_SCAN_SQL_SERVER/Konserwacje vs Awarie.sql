USE JDE_Scan_prod
SELECT pl.Name as [Zasób], s.Name as [Instalacja], CONVERT(date,p.StartedOn) as Data, at.Name as Typ, SUM(DATEDIFF(n, h.StartedOn, h.FinishedOn)) as [Czas]
FROM JDE_Handlings h
	LEFT JOIN JDE_Processes p ON p.ProcessId=h.ProcessId
	LEFT JOIN JDE_Places pl ON pl.PlaceId=p.PlaceId
	LEFT JOIN JDE_Sets s ON s.SetId=pl.SetId
	LEFT JOIN JDE_ActionTypes at ON at.ActionTypeId=p.ActionTypeId
WHERE (at.Name = 'Konserwacja' OR at.Name = 'Awaria') AND h.FinishedOn IS NOT NULL
GROUP BY pl.Name, s.Name, at.Name, CONVERT(date,p.StartedOn)
ORDER BY Data DESC, pl.Name ASC