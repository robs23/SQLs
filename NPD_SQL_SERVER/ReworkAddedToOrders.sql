SELECT oFrom.sapId as [From order], oTo.sapId as [To order], SUM(r.RAmount) as [Amount] 
FROM tbRework r LEFT JOIN tbOrders oTo ON r.RTo=oTo.orderId 
LEFT JOIN tbOrders oFrom ON r.RFrom=oFrom.orderId
WHERE oTo.sapId IN (
12071842,
12071846,
12071887
)
GROUP BY oFrom.sapId, oTo.sapId