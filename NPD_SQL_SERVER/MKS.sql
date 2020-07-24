DECLARE @startDate datetime = '2017-10-29 14:00:00',
		@endDate datetime = '2017-11-05 14:00:00'
SELECT TOP (1000) SUM(main.[Roznica])+(SELECT SUM(sub.Smieci) FROM [Prima].[dbo].[GOODS_MOVEMENT_DETAILS] sub where sub.NumerPZ is not null and sub.DataDostawy BETWEEN (@startDate) and (@endDate) and sub.[WagaBrutto]>0) as Roznica
      ,SUM(main.[Smieci]) as Smieci
	  ,SUM(main.[WagaNettoDekl]) as NettoDeklarowana
	  ,SUM(main.WagaBruttoDekl) as WagaBruttoDeklarowana
	  ,SUM(main.[WagaNetto]) as WagaNetto
	  ,SUM(main.[WagaBrutto]) as WagaBrutto
  FROM [Prima].[dbo].[GOODS_MOVEMENT_DETAILS] main
where main.NumerPZ is not null and main.DataDostawy BETWEEN (@startDate) and (@endDate) and main.[WagaBrutto]>0
