SELECT o.mesId,o.mesString, z.zfinIndex,z.zfinName, od.plMoment,od.plShift, m.machineName as Maszyna, cs.custString as Klient, od.plAmount as PC, ROUND(od.plAmount*u.unitWeight,1) as KG, ROUND(od.plAmount/u.pcPerBox,1) AS BOX, ROUND(od.plAmount/u.pcPerPallet,1) AS PAL ,o.type, zp.[beans?] as bean, zp.[decafe?] as decaf,CASE WHEN cs.custString IS NOT NULL THEN LEFT(cs.custString,2) ELSE 'UNKNOWN' END as Kierunek,CASE WHEN p.palletLength+p.palletWidth = 2000 THEN 'EUR' ELSE CASE WHEN p.palletLength+p.palletWidth = 2200 THEN 'IND' ELSE 'UNKNOWN' END END AS palType, p.palletChep AS Chep, u.pcPerPallet as PC_PAL, u.pcPerBox as PC_BOX, ROUND(1/u.unitWeight,1) as PC_KG, ROUND(u.pcPerPallet*u.unitWeight,1) as KG_PAL, ROUND(u.pcPerBox*u.unitWeight,1) as KG_BOX, u.pcPerPallet/u.pcPerBox as BOX_PAL, 'Wszystkie' as brak, cs.location as loc 
FROM tbOperations o LEFT JOIN tbOperationData od ON od.operationId=o.operationId LEFT JOIN tbZfin z ON z.zfinId=o.zfinId LEFT JOIN tbMachine m ON m.machineId=od.plMach LEFT JOIN tbZfinProperties zp ON zp.zfinId=z.zfinId LEFT JOIN tbUom u ON u.zfinId=z.zfinId LEFT JOIN tbCustomerString cs ON cs.custStringId = z.custString LEFT JOIN tbPallets p ON p.palletId=u.palletType 
WHERE od.plMoment >= '2017-10-29 22:00:00' AND od.plMoment < '2017-11-05 21:00:00' AND o.type = 'p' 
ORDER BY Maszyna DESC, plMoment ASC
