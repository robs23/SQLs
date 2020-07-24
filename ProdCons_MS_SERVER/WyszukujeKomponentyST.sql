SELECT * FROM tbZfin comp RIGHT JOIN
(SELECT a.zfinId FROM
(SELECT *
FROM tbMaterialType mt LEFT JOIN tbZfin z ON z.materialType=mt.materialTypeId
WHERE mt.materialTypeId=4) a
WHERE LEFT(a.zfinName,2) = 'ST') b ON comp.zfinId=b.zfinId