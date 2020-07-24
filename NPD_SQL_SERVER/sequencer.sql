SELECT DISTINCT o1.sapId as zfin, o1.executedSap*u.unitWeight as SAP
FROM tbOrders o RIGHT JOIN tbOrderDep od ON o.orderId = od.zforOrder RIGHT JOIN tbOrders o1 ON o1.orderId=od.zfinOrder LEFT JOIN tbUom u ON o1.zfinId = u.zfinId
WHERE (o.sapId = 11819831 or o.sapId=11819836) and o1.executedSap*u.unitWeight is not null
GROUP BY o1.sapId, o1.executedSap*u.unitWeight