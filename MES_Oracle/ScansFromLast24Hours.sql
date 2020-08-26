SELECT        scan.MACHINE_ID, to_char(scan.C_DATE, 'HH24') AS SCAN_HOUR, to_char(scan.C_DATE, 'YYYY-MM-DD') AS SCAN_DAY, SUM(scan.SCAN_COUNT) AS QUANTITY, uom.WEIGHT_NETTO, SUM(scan.ERROR_COUNT) AS ERROR, 
                         scan.EAN_TYPE, op_qty.PRODUCT_ID, prod.PRODUCT_NR
FROM            QMES_WIP_SCAN_COUNT scan LEFT OUTER JOIN
                         QMES_WIP_OPERATION_QTY op_qty ON op_qty.OPERATION_ID = scan.OPERATION_ID LEFT OUTER JOIN
                         QCM_PRODUCTS prod ON prod.PRODUCT_ID = op_qty.PRODUCT_ID LEFT OUTER JOIN
                         QCM_PACKAGE_HEADERS pack ON pack.PRODUCT_ID = prod.PRODUCT_ID LEFT OUTER JOIN
                         QCM_PACKAGE_LEVELS uom ON uom.PACKAGE_ID = pack.PACKAGE_ID
WHERE        (scan.C_DATE >= '2020-08-25') AND (scan.MACHINE_ID = 326) AND (scan.EAN_TYPE = 2) AND (uom.LEVEL_NR = 0)
GROUP BY scan.MACHINE_ID, to_char(scan.C_DATE, 'HH24'), to_char(scan.C_DATE, 'YYYY-MM-DD'), scan.EAN_TYPE, op_qty.PRODUCT_ID, prod.PRODUCT_NR, uom.WEIGHT_NETTO
ORDER BY SCAN_DAY, SCAN_HOUR