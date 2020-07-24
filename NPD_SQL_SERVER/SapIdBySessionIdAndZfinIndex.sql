
USE npd
SELECT DISTINCT oZfor.sapId as [Zfor order], op.SessionNumber
FROM tbZfin z LEFT JOIN tbOperations op ON op.zfinId=z.zfinId
LEFT JOIN tbOrders oZfor ON oZfor.orderId=op.orderId
WHERE op.SessionNumber=496 AND z.zfinIndex=34005471



