USE JDE_Scan_prod
SELECT pa.ProcessId, pa.ActionId, COUNT(pa.ActionId) as Counter
FROM JDE_ProcessActions pa
GROUP BY pa.ProcessId, pa.ActionId
HAVING COUNT(pa.ActionId) >1
