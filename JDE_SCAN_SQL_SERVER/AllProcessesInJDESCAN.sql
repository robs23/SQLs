SELECT pr.ProcessId, pr.StartedOn, sb.Name + ' ' + sb.Surname as StartedBy, pr.FinishedOn, fb.Name + ' ' + fb.Surname as FinishedBy,
	CASE WHEN pr.IsSuccessfull=1 OR pr.IsCompleted=1 THEN 'Zrealizowany'
	ELSE CASE WHEN pr.IsFrozen=1 THEN 'Wstrzymany' ELSE CASE WHEN pr.IsActive=1 THEN 'Rozpoczêty' END END END as Status, 
	at.Name as ActivityType, pl.Name as Place, DATEDIFF(minute, pr.StartedOn,pr.FinishedOn) as Duration, pr.Output, pr.MesId, pr.InitialDiagnosis, pr.RepairActions, cb.Name + ' ' + cb.Surname as CreatedBy
FROM JDE_Processes pr LEFT JOIN JDE_Users sb ON sb.UserId=pr.StartedBy
LEFT JOIN JDE_Users fb ON fb.UserId=pr.FinishedBy
LEFT JOIN JDE_ActionTypes at ON at.ActionTypeId=pr.ActionTypeId
LEFT JOIN JDE_Places pl ON pl.PlaceId=pr.PlaceId
LEFT JOIN JDE_Users cb ON cb.UserId=pr.CreatedBy
ORDER BY pr.ProcessId DESC