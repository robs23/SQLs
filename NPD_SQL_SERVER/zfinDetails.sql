SELECT z.zfinType, z.zfinIndex, z.zfinName, z1.zfinIndex, z1.zfinName, u.unitWeight, u.pcPerPallet, u.pcPerBox, u.pcLayer,
	CAST(p.palletLength as varchar(4)) + 'x' + CAST(p.palletWidth as varchar(3)) + CASE WHEN p.palletChep<>0 THEN ' CHEP' ELSE ' NIE CHEP' END as Pallet,
	zp.[beans?] as beany, zp.[decafe?] as decafy, zp.[eco?] as ecy, zp.[utz?] as utzy, zp.[single-origin?] as singly, zp.[aromatic?] as ary
FROM tbZfin z LEFT JOIN tbZfinZfor zz ON z.zfinId=zz.zfinId LEFT JOIN tbZfin z1 ON z1.zfinId = zz.zforId 
	LEFT JOIN tbUom u ON z.zfinId = u.zfinId LEFT JOIN tbPallets p ON u.palletType = p.palletId
	LEFT JOIN tbZfinProperties zp ON z.zfinId=zp.zfinId
WHERE z.zfinIndex=4009033
