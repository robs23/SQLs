SELECT CONVERT(date,qr.qDate) as [Data],
qr.delNumber as [Delivery Note],
SUM(qd.batchSize*u.unitWeight) as [Iloœæ kg],
(SELECT TOP(1) sht.shipToString + ' ' + cd.companyName + ', ' + cd.companyCountry FROM tbDeliveryDetail dd LEFT JOIN tbShipTo sht ON sht.shipToId=dd.shipToId LEFT JOIN tbCompanyDetails cd ON cd.companyId=sht.companyId WHERE CHARINDEX(CONVERT(nvarchar,qr.delNumber),dd.deliveryNote)>0) as [Miejsce dostawy]
FROM tbQdocReconciliation qr LEFT JOIN tbQdocData qd ON  qr.qReconciliationId=qd.qReconciliationId LEFT JOIN tbBatch b ON b.batchId=qd.batchId LEFT JOIN tbZfin z ON z.zfinId=b.zfinId LEFT JOIN tbUom u ON u.zfinId=z.zfinId 
WHERE z.zfinIndex=4045798 and qr.qType='WHD_WZ'
GROUP BY qr.qDate, qr.delNumber
ORDER BY [Data] DESC;