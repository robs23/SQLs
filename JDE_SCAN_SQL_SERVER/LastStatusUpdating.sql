USE JDE_Scan_prod
UPDATE JDE_Processes
SET LastStatusOn = FinishedOn
WHERE IsCompleted=1 AND LastStatus < 5

UPDATE JDE_Processes
SET LastStatusBy = FinishedBy
WHERE IsCompleted=1 AND LastStatus < 5

UPDATE JDE_Processes
SET LastStatus = 5
WHERE IsCompleted=1 AND LastStatus < 5