SELECT CONVERT(char(4),YEAR(t.transportDate)) + '_' + CASE WHEN DATEPART(ISO_WEEK,t.transportDate) >9 THEN CONVERT(varchar(2),DATEPART(ISO_WEEK,t.transportDate)) ELSE '0' + CONVERT(varchar(2),DATEPART(ISO_WEEK,t.transportDate)) END as [Data],
 COUNT(DISTINCT t.transportNumber) as [Liczba transportów], sh.shipToString + ' ' + cdSh.companyCity + ', ' + cdSh.companyCountry as [Miejsce]
FROM tbCompanyDetails cd LEFT JOIN tbCarriers car ON car.companyId=cd.companyId LEFT JOIN tbTransport t ON t.carrierId=car.carrierId LEFT JOIN tbCmr cmr ON cmr.transportId=t.transportId LEFT JOIN tbDeliveryDetail dd ON dd.cmrDetailId=cmr.detailId 
LEFT JOIN tbShipTo sh ON sh.shipToId=dd.shipToId LEFT JOIN tbCompanyDetails cdSh ON cdSh.companyId=sh.companyId
WHERE cd.companyId=48
GROUP BY CONVERT(char(4),YEAR(t.transportDate)) + '_' + CASE WHEN DATEPART(ISO_WEEK,t.transportDate) >9 THEN CONVERT(varchar(2),DATEPART(ISO_WEEK,t.transportDate)) ELSE '0' + CONVERT(varchar(2),DATEPART(ISO_WEEK,t.transportDate)) END,
sh.shipToString + ' ' + cdSh.companyCity + ', ' + cdSh.companyCountry
ORDER BY Data DESC