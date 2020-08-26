SELECT        prod.PRODUCT_ID, prod.PRODUCT_NR, prod_lev.PACKAGE_ID, prod_lev.LEVEL_NR, prod_lev.INFO, prod_lev.WEIGHT_BRUTTO, prod_lev.WEIGHT_NETTO, prod_lev.LENGTH, prod_lev.WIDTH, prod_lev.HEIGHT, 
                         prod_lev.BU_QUANTITY, prod_lev.EAN
FROM            QCM_PRODUCTS prod LEFT OUTER JOIN
                         QCM_PACKAGE_HEADERS pack ON prod.PRODUCT_ID = pack.PRODUCT_ID LEFT OUTER JOIN
                         QCM_PACKAGE_LEVELS prod_lev ON pack.PACKAGE_ID = prod_lev.PACKAGE_ID
WHERE        (prod.PRODUCT_NR = '4009033')