USE JDE_Scan_prod
UPDATE t1
SET t1.PlaceId = t2.PlaceId
FROM JDE_PartUsages t1 LEFT JOIN JDE_Processes t2 ON t1.ProcessId = t2.ProcessId
WHERE t1.PlaceId = 0