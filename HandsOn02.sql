--Question 01
DECLARE
lv_test_date DATE := '18-DEC-20';
lv_test_num CONSTANT NUMBER(3) := 10;
lv_test_txt VARCHAR2(10);
BEGIN
lv_test_txt := 'molinaro';
DBMS_OUTPUT.put_LINE(lv_test_txt);
DBMS_OUTPUT.put_LINE(lv_test_num);
DBMS_OUTPUT.put_LINE(lv_test_date);
END; 



--Question 02 and 03
DECLARE
lv_total NUMBER(6,2) := 350;
BEGIN
    IF lv_total > 200 THEN 
        dbms_output.put_line('HIGH');
    ELSIF lv_total < 200 THEN
        dbms_output.put_line('Low');
    ELSE
        dbms_output.put_line('MID');
    END IF;
END;




--Question 04
DECLARE
    lv_p_amt NUMBER(3) := 50;
BEGIN
    CASE lv_p_amt
        WHEN 200 THEN
            DBMS_OUTPUT.PUT_LINE('Valor eh 200');
        WHEN 100 THEN
            DBMS_OUTPUT.PUT_LINE('Valor eh 100');
        WHEN 50 THEN
            DBMS_OUTPUT.PUT_LINE('Valor eh 50');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Valor desconhecido');
    END CASE;
END;




--Question 05
DECLARE
lv_balance NUMBER(6,2) := 2734.01;
lv_pay_rec BOOLEAN := TRUE;
BEGIN
    IF lv_pay_rec THEN
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(lv_balance, '$9,999.99'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('No payment confirmed');
    END IF;
END;




--Question 06
DECLARE
lv_price NUMBER(2) := 30;
lv_money NUMBER(6) := 300;
lv_count NUMBER(2) := 1;
BEGIN
    LOOP
        lv_money := lv_money - lv_price;
        DBMS_OUTPUT.PUT_LINE('You can buy ' || lv_count);
        EXIT WHEN lv_money < lv_price;
        lv_count := lv_count + 1;
    END LOOP;
END;









--Question 07 and 08




--Question 09

--Question 10


