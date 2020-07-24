USE npd
SELECT AVG(bmd.cleaningLoss) as cleaningLoss,
AVG(bmd.zLoss) as zLoss,
AVG(bmd.receiptLoss) as receiptLoss,
AVG(1-(bmd.outRoastBeans/ bmd.inRoastBeans)) as BeanRoastingLoss,
AVG(1-(bmd.outRoastGround/ bmd.inRoastGround)) as GroundRoastingLoss,
AVG(1-((bmd.outRoastGround+bmd.outRoastBeans)/ (bmd.inRoastGround+bmd.inRoastBeans))) as TotalRoastingLoss,
AVG(1-(bmd.inPackGround/ bmd.outRoastGround)) as GrindingLoss,
AVG(1-(bmd.outPackBeans/ bmd.inPackBeans)) as BeansPackingLoss,
AVG(1-(bmd.outPackGround/ bmd.inPackGround)) as GroundPackingLoss,
AVG(1-((bmd.outPackBeans+bmd.outPackGround)/ (bmd.inPackBeans+bmd.inPackGround))) as TotalPackingLoss
FROM tbBM bm 
LEFT JOIN tbBMDetails bmd ON bm.bmId=bmd.bmId
WHERE bm.bmWeek > 18 AND bm.bmYear=2019