SELECT SUM(tots.SlotsBooked) as  SlotsTaken, (SELECT CASE WHEN SUM(cr.slotsTaken) IS NULL THEN 0 ELSE SUM(cr.slotsTaken) END FROM tbCalendarRestrictions cr WHERE DATEPART(ISO_WEEK, cr.calDate)=21 AND YEAR(cr.calDate)=2019) As Restrictions, (SELECT TOP(1) newValue from tbSettingChanges s WHERE s.settingId=1 ORDER BY s.modificationDate DESC)*5 as SlotsPossible FROM 
(SELECT trans.transportDate, trans.SlotsBooked, CASE WHEN cr.slotsTaken IS NULL THEN 0 ELSE cr.slotsTaken END AS slotsTaken FROM 
(SELECT t.transportDate, COUNT(t.transportDate) AS SlotsBooked
FROM tbTransport t
WHERE DATEPART(ISO_WEEK,t.transportDate) = 21 AND YEAR(t.transportDate)=2019
GROUP BY t.transportDate) trans LEFT JOIN tbCalendarRestrictions cr ON cr.calDate=trans.transportDate) tots