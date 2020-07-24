UPDATE t
SET t.truckNumbers = cv.VariableValue
FROM tbCmr cmr LEFT JOIN tbTransport t ON t.transportId=cmr.transportId LEFT JOIN tbCustomVars cv ON cv.CmrId=cmr.cmrId
WHERE cv.VariableName='NUMERY_AUTA' AND cv.VariableValue IS NOT NULL AND t.transportNumber IS NOT NULL