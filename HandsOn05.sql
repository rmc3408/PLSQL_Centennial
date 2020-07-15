CREATE OR REPLACE PROCEDURE prod_add_sp
(p_name IN bb_product.productname%TYPE,
p_descrip IN bb_product.description%TYPE,
p_image IN bb_product.productimage%TYPE,
p_price IN bb_product.price%TYPE,
p_active IN bb_product.active%TYPE)
IS
BEGIN
INSERT INTO bb_product (idproduct, productname, description,
productimage, price, active)
VALUES (bb_prodid_seq.NEXTVAL, p_name, p_descrip, p_image, p_price,
p_active);
COMMIT;
END;

BEGIN
prod_add_sp('Roasted Blend','Well-balanced mix of roasted beans,
a medium body','roasted.jpg',9.50,1);
END;


---------------------------------------

CREATE OR REPLACE PROCEDURE prod_add_sp
(p_name IN bb_product.productname%TYPE,
p_descrip IN bb_product.description%TYPE,
p_image IN bb_product.productimage%TYPE,
p_price IN bb_product.price%TYPE,
p_active IN bb_product.active%TYPE)
IS
BEGIN
INSERT INTO bb_product (idproduct, productname, description,
productimage, price, active)
VALUES (bb_prodid_seq.NEXTVAL, p_name, p_descrip, p_image, p_price,
p_active);
COMMIT;
END;

BEGIN
prod_add_sp('Roasted Blend','Well-balanced mix of roasted beans,
a medium body','roasted.jpg',9.50,1);
END;

--------------------------------------------------

CREATE OR REPLACE FUNCTION dollar_fmt_sf
(p_num NUMBER)
RETURN VARCHAR2
IS
lv_amt_txt VARCHAR2(20);
BEGIN
lv_amt_txt := TO_CHAR(p_num,'$99,999.99');
RETURN lv_amt_txt;
END;

DECLARE
lv_amt_num NUMBER(8,2) := 9999.55;
BEGIN
DBMS_OUTPUT.PUT_LINE(dollar_fmt_sf(lv_amt_num));
END;

SELECT dollar_fmt_sf(shipping), dollar_fmt_sf(total)
FROM bb_basket
WHERE idBasket = 3;