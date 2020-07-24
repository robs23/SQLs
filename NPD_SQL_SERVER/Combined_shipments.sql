use [npd]
SELECT t.transportId as [ID], t.transportNumber as [Numer transportu],COUNT(cmr.cmrId) as [Liczba miejsc], t.transportDate as [Data],
(SELECT (
SELECT ', ' + dd.deliveryNote FROM 
tbTransport tt LEFT JOIN tbCmr cmr ON cmr.transportId=tt.transportId LEFT JOIN tbDeliveryDetail dd ON dd.cmrDetailId=cmr.detailId
WHERE tt.transportId=t.transportId
FOR XML PATH('')) as Deliverki) as [Delivery note],
(SELECT (
SELECT ', ' + cd.companyCity FROM 
tbTransport tt LEFT JOIN tbCmr cmr ON cmr.transportId=tt.transportId LEFT JOIN tbDeliveryDetail dd ON dd.cmrDetailId=cmr.detailId LEFT JOIN tbShipTo sh ON sh.shipToId=dd.shipToId LEFT JOIN tbCompanyDetails cd ON cd.companyId=sh.companyId
WHERE tt.transportId=t.transportId
FOR XML PATH('')) as Miejsca) as [Miejsca roz³adunku]
FROM tbCmr cmr LEFT JOIN tbTransport t ON t.transportId=cmr.transportId
WHERE YEAR(t.transportDate)=2017
GROUP BY  t.transportId, t.transportNumber, t.transportDate
HAVING COUNT(cmr.cmrId) > 1
ORDER BY t.transportDate
