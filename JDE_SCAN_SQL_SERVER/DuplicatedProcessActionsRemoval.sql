USE JDE_Scan_prod
DELETE FROM JDE_ProcessActions WHERE ProcessActionId IN(
SELECT pa1.ProcessActionId FROM
(SELECT pa.ProcessId, pa.ActionId, COUNT(pa.ActionId) as Counter
FROM JDE_ProcessActions pa
GROUP BY pa.ProcessId, pa.ActionId
HAVING COUNT(pa.ActionId) >1) t
LEFT JOIN JDE_ProcessActions pa1 ON pa1.ProcessId=t.ProcessId AND pa1.ActionId=t.ActionId
WHERE pa1.IsChecked IS NULL OR pa1.IsChecked=0) 
