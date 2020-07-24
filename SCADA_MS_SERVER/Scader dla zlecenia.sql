USE [Prima]
select DISTINCT z.NUMERPIECA, z.SUMA_ZIELONEJ, z.ILOSC_PALONA, z.DTZAPIS, zl.OrderNumber, zl.MaterialNumber, zl.NAZWARECEPT, z.dtLastEdited as InnaData1, w.dtCreated as InnaData2, w.dtLastEdited as InnaData3, w.DTZAPIS as InnaData4
from ZLECENIA_PALONA z Join ZLECENIAWARTOSCI w ON (z.IDZLECENIE = w.IDZLECENIE) JOIN ZLECENIA zl on (w.IDZLECENIE = zl.IDZLECENIE) 
Where zl.OrderNumber=12068620
ORDER BY z.DTZAPIS;

