SELECT CONVERT(date,sh.PlannedDate) as [Plan], 
(SELECT TOP(1) CONVERT(date,t.transportDate) FROM tbDeliveryDetail dd LEFT JOIN tbCmr c ON c.detailId=dd.cmrDetailId LEFT JOIN tbTransport t ON t.transportId=c.transportId WHERE CHARINDEX(CONVERT(nvarchar,sh.DeliveryNotes),dd.deliveryNote)>0) as [Wys³ano],
(SELECT TOP(1) sht.shipToString + ' ' + cd.companyName + ', ' + cd.companyCountry FROM tbDeliveryDetail dd LEFT JOIN tbShipTo sht ON sht.shipToId=dd.shipToId LEFT JOIN tbCompanyDetails cd ON cd.companyId=sht.companyId WHERE CHARINDEX(CONVERT(nvarchar,sh.DeliveryNotes),dd.deliveryNote)>0) as [Miejsce dostawy],
(SELECT TOP(1) CASE WHEN t.transportStatus = 2 THEN 'Wys³ano' ELSE 'Oczekuje' END FROM tbDeliveryDetail dd LEFT JOIN tbCmr c ON c.detailId=dd.cmrDetailId LEFT JOIN tbTransport t ON t.transportId=c.transportId WHERE CHARINDEX(CONVERT(nvarchar,sh.DeliveryNotes),dd.deliveryNote)>0) as Status,
sh.DeliveryNotes as [Delivery Note], poi.Amount as [PC],
poi.Amount*u.unitWeight as [KG],
poi.Amount/u.pcPerPallet as [PAL]
FROM tbPlannedShipments sh
LEFT JOIN tbPo po ON po.shipmentId=sh.PlannedShipmentId
LEFT JOIN tbPoItem poi ON poi.PoId=po.PoId
LEFT JOIN tbZfin z ON z.zfinId=poi.ProductId
LEFT JOIN tbUom u ON u.zfinId=z.zfinId
WHERE z.zfinIndex=4009033
ORDER BY PlannedDate