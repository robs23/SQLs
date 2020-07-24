SELECT CONVERT(date,sh.PlannedDate) as [Data], 
'Wysy³ka' as [Typ],
poi.Amount as [PC],
poi.Amount*u.unitWeight as [KG],
poi.Amount/u.pcPerPallet as [PAL],
sh.DeliveryNotes as [Delivery Note],
(SELECT TOP(1) sht.shipToString + ' ' + cd.companyName + ', ' + cd.companyCountry FROM tbDeliveryDetail dd LEFT JOIN tbShipTo sht ON sht.shipToId=dd.shipToId LEFT JOIN tbCompanyDetails cd ON cd.companyId=sht.companyId WHERE CHARINDEX(CONVERT(nvarchar,sh.DeliveryNotes),dd.deliveryNote)>0) as [Dostawa],
(SELECT TOP(1) CASE WHEN t.transportStatus = 2 THEN 'Wys³ano' ELSE 'Oczekuje' END FROM tbDeliveryDetail dd LEFT JOIN tbCmr c ON c.detailId=dd.cmrDetailId LEFT JOIN tbTransport t ON t.transportId=c.transportId WHERE CHARINDEX(CONVERT(nvarchar,sh.DeliveryNotes),dd.deliveryNote)>0) as [Status]
FROM tbPlannedShipments sh
LEFT JOIN tbPo po ON po.shipmentId=sh.PlannedShipmentId
LEFT JOIN tbPoItem poi ON poi.PoId=po.PoId
LEFT JOIN tbZfin z ON z.zfinId=poi.ProductId
LEFT JOIN tbUom u ON u.zfinId=z.zfinId
WHERE z.zfinIndex=4009079
UNION ALL
SELECT CONVERT(date,ps.PlannedDate) as [Data],
'Zapas' as [Typ],
ps.Amount as [PC], 
ps.Amount*u.unitWeight as [KG], 
ps.Amount/u.pcPerPallet as [PAL],
'' as [Delivery Note],
'' as [Dostawa],
'' as [Status]
FROM tbPlannedStock ps
LEFT JOIN tbZfin z ON ps.ProductId=z.zfinId
LEFT JOIN tbUom u ON u.zfinId=z.zfinId
WHERE z.zfinIndex=4009079
UNION ALL
SELECT od.plMoment as [Data],
'Produkcja' as [Typ],
od.plAmount as PC,
ROUND(od.plAmount*u.unitWeight,1) as KG,
ROUND(od.plAmount/u.pcPerPallet,1) AS PAL,
'' as [Delivery Note],
'' as [Dostawa],
'' as [Status]
FROM tbOperations o LEFT JOIN tbOperationData od ON od.operationId=o.operationId LEFT JOIN tbZfin z ON z.zfinId=o.zfinId LEFT JOIN tbMachine m ON m.machineId=od.plMach LEFT JOIN tbZfinProperties zp ON zp.zfinId=z.zfinId LEFT JOIN tbUom u ON u.zfinId=z.zfinId LEFT JOIN tbCustomerString cs ON cs.custStringId = z.custString LEFT JOIN tbPallets p ON p.palletId=u.palletType
WHERE od.plMoment >= '2019-09-22 22:00:00' AND od.plMoment < '2019-10-06' AND o.type = 'p' AND z.zfinIndex=4009079
ORDER BY [Data]