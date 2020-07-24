SELECT        prod.PRODUCT_ID, prod.PRODUCT_NR, prod_lev.PACKAGE_ID, prod_lev.LEVEL_NR, prod_lev.PRODUCT_ID AS EXPR1, prod_lev.INFO, prod_lev.IS_LAYER, prod_lev.IS_FULL_LU, prod_lev.IS_INPUT, prod_lev.IS_OUTPUT, 
                         prod_lev.IS_STORED, prod_lev.WEIGHT_BRUTTO, prod_lev.WEIGHT_NETTO, prod_lev.LENGTH, prod_lev.WIDTH, prod_lev.HEIGHT, prod_lev.VOLUME, prod_lev.BU_QUANTITY, prod_lev.LU_QUANTITY, prod_lev.EAN, 
                         prod_lev.EXPORT_ID, prod_lev.IMPORT_ID, prod_lev.STATUS, prod_lev.C_DATE, prod_lev.C_USER, prod_lev.LM_DATE, prod_lev.LM_USER, prod_lev.IS_INTERNAL
FROM            QCM_PRODUCTS prod LEFT OUTER JOIN
                         QCM_PACKAGE_HEADERS pack ON prod.PRODUCT_ID = pack.PRODUCT_ID LEFT OUTER JOIN
                         QCM_PACKAGE_LEVELS prod_lev ON pack.PACKAGE_ID = prod_lev.PACKAGE_ID
WHERE        (prod.PRODUCT_NR = '4009033')