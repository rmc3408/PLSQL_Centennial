CREATE OR REPLACE PACKAGE prod_pkg IS
PROCEDURE stkup_pp
(p_id IN bb_product.idproduct%TYPE,
p_qty IN NUMBER);
END;



CREATE OR REPLACE PACKAGE BODY prod_pkg IS

FUNCTION stk_pf
(p_id IN bb_product.idproduct%TYPE)
RETURN NUMBER
IS
lv_stk_num bb_product.stock%TYPE;
BEGIN
SELECT stock
INTO lv_stk_num
FROM bb_product
WHERE idproduct = p_id;
RETURN lv_stk_num;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN 0;
END;
PROCEDURE stkup_pp
(p_id IN bb_product.idproduct%TYPE,
p_qty IN NUMBER)
IS
lv_stk_num bb_product.stock%TYPE;
BEGIN
lv_stk_num := stk_pf(p_id);
IF lv_stk_num >= p_qty THEN
UPDATE bb_product
SET stock = stock - p_qty
WHERE idproduct = p_id;
COMMIT;
ELSE
DBMS_OUTPUT.PUT_LINE('Insufficient Stock');
END IF;
END;
END;


---- test insufficient stock----
BEGIN
prod_pkg.stkup_pp(1,25);
END;

OR

EXECUTE prod_pkg.stkup_pp(1,25);

----- test update -----------
BEGIN
prod_pkg.stkup_pp(1,3);
END;

OR

EXECUTE prod_pkg.stkup_pp(1,3);



----------------------------------------------------------

CREATE OR REPLACE PACKAGE order_info_pkg
IS
FUNCTION ship_name_pf
(p_basket IN NUMBER)
RETURN VARCHAR2;
PROCEDURE basket_info_pp
(p_basket IN NUMBER,
p_shop OUT NUMBER,
p_date OUT DATE);
END;

CREATE OR REPLACE PACKAGE BODY order_info_pkg
IS
FUNCTION ship_name_pf
(p_basket IN NUMBER)
RETURN VARCHAR2
IS
lv_name_txt VARCHAR2(25);
BEGIN
SELECT shipfirstname||' '||shiplastname
INTO lv_name_txt
FROM bb_basket
WHERE idBasket = p_basket;
RETURN lv_name_txt;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Invalid basket id');
END ship_name_pf;
PROCEDURE basket_info_pp
(p_basket IN NUMBER,
p_shop OUT NUMBER,
p_date OUT DATE)
IS
BEGIN
SELECT idshopper, dtordered
INTO p_shop, p_date
FROM bb_basket
WHERE idbasket = p_basket;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Invalid basket id');
END basket_info_pp;
END;

DECLARE
lv_name_txt VARCHAR2(20);
lv_id_num NUMBER(4);
lv_ord_dat DATE;
BEGIN
lv_name_txt := order_info_pkg.ship_name_pf(4);
order_info_pkg.basket_info_pp(4,lv_id_num, lv_ord_dat);
DBMS_OUTPUT.PUT_LINE(lv_name_txt);
DBMS_OUTPUT.PUT_LINE(lv_id_num);
DBMS_OUTPUT.PUT_LINE(lv_ord_dat);
END;

SELECT order_info_pkg.ship_name_pf(idBasket)
FROM bb_basket
WHERE idBasket = 12;