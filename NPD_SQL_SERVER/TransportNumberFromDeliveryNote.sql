SELECT d.deliveryNote, t.transportNumber FROM 
tbDeliveryDetail d LEFT JOIN tbCmr c ON c.detailId=d.cmrDetailId LEFT JOIN tbTransport t ON t.transportId=c.transportId
WHERE CHARINDEX('2440796051',d.deliveryNote)>0