Use npd
SELECT DISTINCT zfin.sapId as [ZFIN], op.SessionNumber, od.isRemoved
FROM tbOrders zfor
LEFT JOIN tbOrderDep od ON od.zforOrder=zfor.orderId
LEFT JOIN tbOrders zfin ON zfin.orderId=od.zfinOrder
LEFT JOIN tbOperations op ON op.orderId=zfin.orderId
WHERE zfor.sapId IN (12288623,
12288770,
12288771)