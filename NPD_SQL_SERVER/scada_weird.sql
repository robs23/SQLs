use [Prima]
SELECT DISTINCT rD.OrderNumber as theOrder FROM (select DISTINCT z.NUMERPIECA, z.SUMA_ZIELONEJ, z.ILOSC_PALONA, z.DTZAPIS, zl.OrderNumber, zl.MaterialNumber, zl.NAZWARECEPT from ZLECENIA_PALONA z Join ZLECENIAWARTOSCI w ON (z.IDZLECENIE = w.IDZLECENIE) JOIN ZLECENIA zl on (w.IDZLECENIE = zl.IDZLECENIE) Where (z.DTZAPIS Between ('2017-01-29 06:00:00') AND ('2017-02-05 03:00:00'))) as rD

select DISTINCT  
zl.OrderNumber as theOrder, 
zl.MaterialNumber as zfor, 
zl.NAZWARECEPT as name,
SUM(z.SUMA_ZIELONEJ) as sumaZielonej, 
SUM(z.ILOSC_PALONA) as sumaPalonej
from ZLECENIA_PALONA z Join ZLECENIAWARTOSCI w ON z.IDZLECENIE = w.IDZLECENIE JOIN ZLECENIA zl on w.IDZLECENIE = zl.IDZLECENIE
WHERE zl.OrderNumber IN (11841445,11841446,11841499,11841500,11841501,11841502,11841503,11841504,11841505,11841506,11841520,11841522,11841524,11841525,11841526,11841566,11841583,11841584,11841585,11841586,11841587,11841588,11841589,11841590,11841591,11841592,11841593,11841594,11841595,11841596,11841597,11841598,11841599,11841600,11841601,11841602,11841603,11841604,11841607,11841608,11841609,11841610,11841611,11841612,11841613,11841627,11841628,11841629,11841630,11841632,11841633,11841634,11841647,11841648,11841649,11841650,11841651,11841652,11841653,11841654,11841655,11841656,11841657,11841658,11841659,11841660,11841661,11841662,11841663,11841664,11841665,11841666,11841667,11841668,11841669,11841670,11842230,11842513,11844498,11844585,11844586,11844589,11844591,11844594) 
GROUP BY zl.OrderNumber, zl.MaterialNumber, zl.NAZWARECEPT 
ORDER BY zfor