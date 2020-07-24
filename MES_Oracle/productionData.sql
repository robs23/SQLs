SELECT        mach.MACHINE_NAME, op_qty.QUANTITY, uom.WEIGHT_NETTO * op_qty.QUANTITY AS QUANTITY_KG, operation.OPERATION_NR, ord.ORDER_NR, prod.PRODUCT_ID, prod.PRODUCT_NR, prod.NAME
FROM            QMES_FO_MACHINE mach LEFT OUTER JOIN
                         QMES_WIP_OPERATION operation ON mach.MACHINE_ID = operation.MACHINE_ID LEFT OUTER JOIN
                         QMES_WIP_ORDER ord ON ord.ORDER_ID = operation.ORDER_ID LEFT OUTER JOIN
                         QMES_WIP_OPERATION_QTY op_qty ON op_qty.OPERATION_ID = operation.OPERATION_ID LEFT OUTER JOIN
                         QCM_PRODUCTS prod ON prod.PRODUCT_ID = op_qty.PRODUCT_ID LEFT OUTER JOIN
                         QCM_PACKAGE_HEADERS pack ON pack.PRODUCT_ID = prod.PRODUCT_ID LEFT OUTER JOIN
                         QCM_PACKAGE_LEVELS uom ON uom.PACKAGE_ID = pack.PACKAGE_ID
WHERE        (mach.MACHINE_NAME = 'Linia 15') AND (operation.OPERATION_TYPE_ID = 11) AND (ord.ORDER_NR = '12344685') AND (uom.LEVEL_NR = 0)