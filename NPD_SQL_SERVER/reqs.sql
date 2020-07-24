SET DATEFIRST 1;
SELECT z.zfinIndex, SUM(r.amount) as amount, DATEPART(ISO_WEEK,r.deliveryDate) as week, LEFT(cs.custString,2) + '_' + cs.location as location
FROM tbReqs r LEFT JOIN tbZfin z ON z.zfinId=r.zfinId LEFT JOIN tbCustomerString cs ON cs.custStringId=z.custString
WHERE (r.deliveryDate BETWEEN '2017-05-22' AND '2017-05-28' AND r.type='po') OR (r.deliveryDate BETWEEN '2017-05-22' AND '2017-06-04' AND r.type='so')
GROUP BY z.zfinIndex, DATEPART(ISO_WEEK,r.deliveryDate), LEFT(cs.custString,2) + '_' + cs.location
ORDER BY z.zfinIndex, week,amount