--Assignment 3-01
SELECT * FROM BB_BASKETSTATUS;

DECLARE
  lv_ship_date bb_basketstatus.dtstage%TYPE;
  lv_shipper_txt bb_basketstatus.shipper%TYPE;
  lv_ship_num bb_basketstatus.shippingnum%TYPE;
  lv_bask_num bb_basketstatus.idbasket%TYPE := 3;
BEGIN
  SELECT dtstage, shipper, shippingnum
   INTO lv_ship_date, lv_shipper_txt, lv_ship_num
   FROM bb_basketstatus
   WHERE idbasket = lv_bask_num
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||lv_ship_date);
  DBMS_OUTPUT.PUT_LINE('Shipper: '||lv_shipper_txt);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '||lv_ship_num);
END;

--Assignment 3-02
DECLARE
  rec_ship bb_basketstatus%ROWTYPE;
  lv_bask_num bb_basketstatus.idbasket%TYPE := 3;
BEGIN
  SELECT *
   INTO rec_ship
   FROM bb_basketstatus
   WHERE idbasket =  lv_bask_num
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||rec_ship.dtstage);
  DBMS_OUTPUT.PUT_LINE('Shipper: '||rec_ship.shipper);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '||rec_ship.shippingnum);
  DBMS_OUTPUT.PUT_LINE('Notes: '||rec_ship.notes);
END;

--Assignment 3-03
DECLARE
 lv_total_num NUMBER(6,2);
 lv_rating_txt VARCHAR2(4);
 lv_shop_num bb_basket.idshopper%TYPE := 22;
BEGIN
 SELECT SUM(total)
  INTO 
  FROM bb_basket
  WHERE idShopper = 
    AND orderplaced = 1
  GROUP BY idshopper;
  IF lv_total_num > 200 THEN
END IF; 
   DBMS_OUTPUT.PUT_LINE('Shopper '||:g_shopper||' is rated '||lv_rating_txt);
END;

--Question 04


--Question 05


--Question 06


--Question 07


--Question 08
--Question 09
--Question 10
CREATE SEQUENCE dd_projid_seq
 START WITH     530
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

declare
rec_proj dd_project%rowtype;
begin
rec_proj.idproj := dd_projid_seq.nextval;
rec_proj.projname := 'HK Animal Shelter Extension';
rec_proj.projstartdate := (to_date( '1/1/2013', 'mm/dd/yyyy'));
rec_proj.projenddate := (to_date ('5/31/2013', 'mm/dd/yyyy'));
rec_proj.projfundgoal := 65000;
insert into dd_project values rec_proj;
commit;
END;

select * from dd_project;
drop sequence dd_projid_seq;
delete from dd_project where idproj = 530;


--Question 11
DECLARE
  PLEDGES DD_PLEDGE%ROWTYPE;
  START_MONTH_DATE DD_PLEDGE.PLEDGEDATE%TYPE := '01-OCT-12';
  END_MONTH_DATE DD_PLEDGE.PLEDGEDATE%TYPE := '31-OCT-12';
BEGIN
  FOR PLEDGES IN 
    (SELECT IDPLEDGE, IDDONOR, PLEDGEAMT, CASE
      WHEN PAYMONTHS = 0 THEN 'Lump Sum.'
      ELSE 'Monthly - ' || PAYMONTHS
      END AS MONTHLY_PAYMENT
      FROM DD_PLEDGE
      WHERE PLEDGEDATE >= START_MONTH_DATE AND PLEDGEDATE <= END_MONTH_DATE
      ORDER BY PAYMONTHS)
      LOOP
      DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || PLEDGES.IDPLEDGE || ', Donor ID: '
        || PLEDGES.IDDONOR || ', Pledge Amount: ' ||to_char(PLEDGES.PLEDGEAMT,
        '$9999.99') || ', Monthly Payments: ' || PLEDGES. MONTHLY_PAYMENT);
      END LOOP;
END;


--Question 12


