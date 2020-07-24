SELECT CONVERT(date,t.transportDate) as [Data], t.transportNumber as [Numer transportu], sh.shipToString + ' ' + cdSh.companyName + ', ' + cdSh.companyCity + ', ' + cdSh.companyCountry as [Miejsce dostawy], dd.deliveryNote as [Delivery Note]  
FROM tbCompanyDetails cd LEFT JOIN tbCarriers car ON car.companyId=cd.companyId LEFT JOIN tbTransport t ON t.carrierId=car.carrierId LEFT JOIN tbCmr cmr ON cmr.transportId=t.transportId LEFT JOIN tbDeliveryDetail dd ON dd.cmrDetailId=cmr.detailId 
LEFT JOIN tbShipTo sh ON sh.shipToId=dd.shipToId LEFT JOIN tbCompanyDetails cdSh ON cdSh.companyId=sh.companyId
WHERE cd.companyId=48
ORDER BY Data DESC