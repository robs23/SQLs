USE npd
SELECT o.sapId, op.SessionNumber 
FROM tbOrders o LEFT JOIN tbOperations op ON op.orderId=o.orderId
WHERE o.sapId IN (12309965)
