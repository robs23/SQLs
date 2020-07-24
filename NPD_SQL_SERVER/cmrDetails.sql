SELECT t.transportId ,t.transportNumber, t.transportDate, t.truckNumbers, t.carrierId,
(SELECT cd.companyName + ', ' + cd.companyAddress + ', ' + cd.companyCode + ', ' + cd.companyCity + ', ' + cd.companyCountry FROM tbCarriers car LEFT JOIN tbCompanyDetails cd ON cd.companyId=car.companyId WHERE car.carrierId=t.carrierId) as CarrierString,
dd.soldToId,
(SELECT s.soldToString + ' ' + cd.companyName + ', ' + cd.companyAddress + ', ' + cd.companyCode + ', ' + cd.companyCity + ', ' + cd.companyCountry FROM tbSoldTo s LEFT JOIN tbCompanyDetails cd ON cd.companyId=s.companyId WHERE s.soldToId=dd.soldToId) as SoldToString,
dd.shipToId,
(SELECT s.shipToString + ' ' + cd.companyName + ', ' + cd.companyAddress + ', ' + cd.companyCode + ', ' + cd.companyCity + ', ' + cd.companyCountry FROM tbShipTo s LEFT JOIN tbCompanyDetails cd ON cd.companyId=s.companyId WHERE s.shipToId=dd.shipToId) as ShipToString,
dd.deliveryNote, dd.weightGross,dd.weightNet,dd.numberPall, dd.germanyIn, dd.germanyOut,
dd.carrierContact,
(SELECT con.contactName + ' '+ con.contactLastname FROM tbContacts con WHERE con.contactId=dd.carrierContact) as contactString,
(SELECT sh.viaGermany FROM tbShipTo sh WHERE sh.shipToId=dd.shipToId) as viaGermany,
dd.cmrTemplate, cTemp.tempName
FROM tbCmr cmr LEFT JOIN tbDeliveryDetail dd ON dd.cmrDetailId=cmr.detailId LEFT JOIN tbTransport t ON t.transportId=cmr.transportId LEFT JOIN tbCmrTemplate cTemp ON dd.cmrTemplate = cTemp.cmrId
WHERE cmr.cmrId=2000