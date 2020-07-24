SELECT CONVERT(date,qr.qDate) as [Data], z.zfinIndex as [Indeks], z.zfinName as [Nazwa], qr.delNumber as [Delivery Note], SUM(qd.batchSize*u.unitWeight) as [Ilosc kg]
FROM tbQdocReconciliation qr LEFT JOIN tbQdocData qd ON qr.qReconciliationId=qd.qReconciliationId LEFT JOIN tbBatch b ON b.batchId=qd.batchId LEFT JOIN tbZfin z ON z.zfinId=b.zfinId LEFT JOIN tbUom u ON u.zfinId=z.zfinId
WHERE CONVERT(nvarchar,qr.delNumber) IN (
SELECT dd.deliveryNote
FROM tbCompanyDetails shCd LEFT JOIN tbShipTo sh ON sh.companyId=shCd.companyId LEFT JOIN tbDeliveryDetail dd ON dd.shipToId=sh.shipToId
WHERE shCd.companyId=31)
GROUP BY qr.qDate, z.zfinIndex, z.zfinName, qr.delNumber
ORDER BY qr.qDate DESC, qr.delNumber