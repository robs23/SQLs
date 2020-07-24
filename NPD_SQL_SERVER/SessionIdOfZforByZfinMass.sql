Use npd
SELECT DISTINCT zfor.sapId as [ZFOR], op.SessionNumber, od.isRemoved
FROM tbOrders zfin
LEFT JOIN tbOrderDep od ON od.zfinOrder=zfin.orderId
LEFT JOIN tbOrders zfor ON zfor.orderId=od.zforOrder
LEFT JOIN tbOperations op ON op.orderId=zfor.orderId
WHERE zfin.sapId IN (12288812,12288928)