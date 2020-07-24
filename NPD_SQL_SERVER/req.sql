DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
DECLARE @ColumnName AS NVARCHAR(MAX)
 
--Get distinct values of the PIVOT Column 
SELECT @ColumnName= ISNULL(@ColumnName + ',','') 
       + QUOTENAME(RTRIM(location))
FROM (SELECT DISTINCT location FROM tbCustomerString) AS Locations

SET @DynamicPivotQuery =
'SELECT zfin,[so], ' + @ColumnName + '
FROM (
SELECT z.zfinIndex as zfin, r.amount/u.pcPerPallet as amount, (CASE WHEN cs.location IS NULL THEN ''so'' ELSE cs.location END) as location
FROM tbReqs r LEFT JOIN tbZfin z ON r.zfinId = z.zfinId LEFT JOIN tbCustomerString cs ON cs.custStringId = r.target
LEFT JOIN tbUom u ON u.zfinId = z.zfinId
WHERE DATEPART(ISO_WEEK,r.DeliveryDate) BETWEEN 11 AND 11
) x 
PIVOT(SUM(amount) FOR location IN ([so],' + @ColumnName + ')) PVTTable'
					
--Execute the Dynamic Pivot Query
EXEC sp_executesql @DynamicPivotQuery
--PRINT @DynamicPivotQuery
