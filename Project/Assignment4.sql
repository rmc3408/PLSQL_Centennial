-- Raphael Molinaro Student ID# 301098080

--DROP TABLES AND SEQUENCES
DROP TABLE A4_customer CASCADE CONSTRAINTS;
DROP TABLE A4_orders CASCADE CONSTRAINTS;
DROP TABLE A4_shipment CASCADE CONSTRAINTS;
DROP TABLE A4_payment CASCADE CONSTRAINTS;
DROP TABLE A4_product CASCADE CONSTRAINTS;
DROP TABLE A4_berryfruit CASCADE CONSTRAINTS;
DROP TABLE A4_discount CASCADE CONSTRAINTS;

DROP SEQUENCE A4_customer_seq;
DROP SEQUENCE A4_orders_seq;
DROP SEQUENCE A4_shipment_seq;
DROP SEQUENCE A4_payment_seq;
DROP SEQUENCE A4_product_seq;
DROP SEQUENCE A4_berryfruit_seq;
DROP SEQUENCE A4_discount_seq;

DROP INDEX order_idx;
DROP INDEX fullname_idx;
DROP INDEX zip_idx;

DROP PROCEDURE FINAL_DISC_PC;
DROP PROCEDURE SHIP_COST_PC;
DROP FUNCTION FRUIT_SIZE_FN;
DROP FUNCTION FRUIT_TOTAL_FN;
DROP TRIGGER display_stock_changes_trg;
DROP TRIGGER check_stock_trg;

-- CREATE SEQUENCES

CREATE SEQUENCE A4_customer_seq
  INCREMENT BY 1
  START WITH 1
  NOCACHE
  NOCYCLE;
CREATE SEQUENCE A4_orders_seq
  INCREMENT BY 1
  START WITH 21
  NOCACHE
  NOCYCLE;
CREATE SEQUENCE A4_shipment_seq
  INCREMENT BY 1
  START WITH 61
  NOCACHE
  NOCYCLE;
CREATE SEQUENCE A4_payment_seq
  INCREMENT BY 1
  START WITH 41
  NOCACHE
  NOCYCLE;
CREATE SEQUENCE A4_product_seq
  INCREMENT BY 1
  START WITH 81
  NOCACHE
  NOCYCLE;
CREATE SEQUENCE A4_berryfruit_seq
  INCREMENT BY 1
  START WITH 101
  NOCACHE
  NOCYCLE;
CREATE SEQUENCE A4_discount_seq
  INCREMENT BY 1
  START WITH 201
  NOCACHE
  NOCYCLE;


-- CREATE TABLES
 
CREATE TABLE A4_customer
(customerid NUMBER DEFAULT A4_customer_seq.NEXTVAL,
firstname VARCHAR2(30),
lastname VARCHAR2(30),
address VARCHAR2(100),
state CHAR(2),
postalcode VARCHAR2(6),
email VARCHAR2(30),
phone NUMBER(10,0),
CONSTRAINT customer_custID_pk PRIMARY KEY(customerid));

CREATE TABLE A4_shipment 
(shipmentid NUMBER DEFAULT A4_shipment_seq.NEXTVAL, 
shipAddress VARCHAR2(100), 
shipPostalCode VARCHAR2(6), 
shipState CHAR(2), 
shipCity VARCHAR2(15), 
shipCost NUMBER(6,2), 
CONSTRAINT shipment_shipmentid_pk PRIMARY KEY (shipmentid));

CREATE TABLE A4_orders
(orderid NUMBER DEFAULT A4_orders_seq.NEXTVAL,
customerid NUMBER (2,0),
orderstatus CHAR(1),
orderdate DATE,
shipmentid NUMBER(4,0),
CONSTRAINT orders_orderid_pk PRIMARY KEY(orderid),
CONSTRAINT orders_customerid_fk FOREIGN KEY(customerid) REFERENCES A4_customer(customerid),
CONSTRAINT orders_orderstatus_ck CHECK(orderstatus='Y' OR orderstatus='N'),
CONSTRAINT orders_shipmentid_fk FOREIGN KEY(shipmentid) REFERENCES A4_shipment (shipmentid));

CREATE TABLE A4_payment
(paymentid NUMBER(4,0) DEFAULT A4_payment_seq.NEXTVAL,
orderid NUMBER(4,0),
paymentduedate DATE,
paymentstatus CHAR(1),
CONSTRAINT porder_paymentid_pk PRIMARY KEY(paymentid),
CONSTRAINT porder_orderid_fk FOREIGN KEY(orderid) REFERENCES A4_orders(orderid),
CONSTRAINT porder_paymentstatus_ck CHECK(paymentstatus='Y' OR paymentstatus='N'));

CREATE TABLE A4_berryfruit
(fruitcode NUMBER(4,0) DEFAULT A4_berryfruit_seq.NEXTVAL,
category VARCHAR2(20),
stockquantity NUMBER(6,2),
retailprice NUMBER(8,2),
constraint berryfruit_fruitcode_pk PRIMARY KEY (fruitcode));

CREATE TABLE A4_product 
(productid NUMBER(4,0) DEFAULT A4_product_seq.NEXTVAL, 
orderid NUMBER(4,0), 
fruitcode NUMBER(4,0), 
unit NUMBER(6,2), 
payedprice NUMBER(8,2), 
CONSTRAINT product_productid_pk PRIMARY KEY (productid), 
CONSTRAINT product_orderid_fk FOREIGN KEY (orderID) REFERENCES A4_orders (orderid), 
CONSTRAINT product_fruitcode_fk FOREIGN KEY (fruitcode) REFERENCES A4_berryfruit (fruitcode));

CREATE TABLE A4_discount (
   discountid NUMBER DEFAULT A4_discount_seq.NEXTVAL,
   orderid NUMBER(4,0),
   disc_value NUMBER(3,2) DEFAULT 1.00 ,
CONSTRAINT discountid_pk PRIMARY KEY (discountid),
CONSTRAINT disc_orderid_fk FOREIGN KEY (orderid) REFERENCES A4_orders(orderid) );

---- Fill the Tables
INSERT INTO A4_customer
VALUES (DEFAULT, 'JHOSUA', 'OBAMA', '547 BLOOR ST.', 'ON', 'M4Y1C5', 'jhosua@gmail.com', 6475738778);
INSERT INTO A4_customer
VALUES (DEFAULT, 'JASON', 'KENNETH', '771 ABBEY ROAD', 'QB', 'H3Y3A7', 'jkenneth@gmail.com', 4385797653);
INSERT INTO A4_customer
VALUES (DEFAULT, 'JANET', 'MESHIA', '114 GREAT JONES ST.', 'OT', 'K2R7C2', 'jacob@gmail.com', 5195009813);
INSERT INTO A4_customer
VALUES (DEFAULT, 'JACOB', 'WILLIAM', '985 BOWERY AVENUE', 'OT', 'K2R4C2', 'jwilliam@gmail.com', 5145737123);
INSERT INTO A4_customer
VALUES (DEFAULT, 'GEORGE', 'LEE', '8 VICTORIA AVENUE', 'BC', 'V6A9C0', 'george@gmail.com', 2505790897);
INSERT INTO A4_customer
VALUES (DEFAULT, 'JOHN', 'NELSON', '1447 CAMBRAI AVENUE', 'MN', 'R3A1B7', 'john@gmail.com', 2045738954);
INSERT INTO A4_customer
VALUES (DEFAULT, 'CLAIR', 'KEITH', '7 ZAMBUE AVENUE', 'SK', 'S3A1B7', 'nclair@gmail.com', 2045735689);
INSERT INTO A4_customer
VALUES (DEFAULT, 'SOMYA', 'TOTAL', '33 ISABELLA AVENUE', 'MN', 'R3A1B7', 'somya263@gmail.com', 2045731002);
INSERT INTO A4_customer
VALUES (DEFAULT, 'TEREZA', 'SMITH', '1000 CAMBRAI AVENUE', 'MN', 'R3A1B7', 'angrybird@gmail.com', 2045738102);
INSERT INTO A4_customer
VALUES (DEFAULT, 'CLARA', 'RODRIGUES', '971 PROGRESS AVENUE', 'ON', 'M3H2P7', 'claraRod@gmail.com', 4165738954);


INSERT INTO A4_shipment (shipaddress, shippostalcode, shipstate, shipcity, shipcost)
VALUES ('1257 ISABELLA AVENUE.', 'M7L1A9', 'ON','TORONTO', 4.99);
INSERT INTO A4_shipment
VALUES (DEFAULT, '7895 SOUTH AVENUE', 'H3Y3B3', 'QB', 'QUEBEC', 15.99);
INSERT INTO A4_shipment 
VALUES (DEFAULT, '900 DIRT ROAD', 'K2R7A1','ON', 'OTTAWA', 93.99);
INSERT INTO A4_shipment 
VALUES (DEFAULT, '42 MAIN STREET', 'K2R4B2', 'ON', 'OTTAWA', 92.99);
INSERT INTO A4_shipment 
VALUES (DEFAULT, '348 EAGLE AVENUE', 'V6A9B7', 'BC', 'VANCOUVER', 42.99);
INSERT INTO A4_shipment
VALUES (DEFAULT, '89307 LONG AVENUE', 'R3A1A4', 'MN','CALGARY', 39.99);
INSERT INTO A4_shipment (shipaddress, shippostalcode, shipstate, shipcity, shipcost)
VALUES ('33 ISABELLA AVENUE.', 'M7S1A9', 'ON','TORONTO', 4.99);
INSERT INTO A4_shipment (shipaddress, shippostalcode, shipstate, shipcity, shipcost)
VALUES ('38 ISABELLA AVENUE.', 'M7L2A8', 'ON','TORONTO', 4.99);
INSERT INTO A4_shipment 
VALUES (DEFAULT, '900 DIRT ROAD', 'M2R7A1','ON', 'OTTAWA', 93.99);
INSERT INTO A4_shipment 
VALUES (DEFAULT, '42 MAIN STREET', 'M2R4B2', 'ON', 'OTTAWA', 92.99);
INSERT INTO A4_shipment 
VALUES (DEFAULT, '9 DIRT ROAD', 'M2R7A1','ON', 'OTTAWA', 93.99);
INSERT INTO A4_shipment 
VALUES (DEFAULT, '42 MAIN STREET', 'M2R4B2', 'ON', 'OTTAWA', 102.99);


INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'CHERRYBERRIES', 1000, 5.50);
INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'SUPERBERRIES', 50, 19.50);
INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'BLUEBERRIES', 1000, 1.50);
INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'RASPBERRIES', 3000, 9.60);
INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'GOJIBERRIES', 5000, 10.00);
INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'STRAWBERRIES', 9000, 4.50);
INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'SWEETBERRIES', 500, 12.60);
INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'SALTBERRIES', 500, 9.30);
INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'CRANBERRIES', 500, 2.60);
INSERT INTO A4_berryfruit
VALUES (DEFAULT, 'ACAIBERRIES', 500, 2.00);


INSERT INTO A4_orders
VALUES (DEFAULT, 1, 'Y', TO_DATE('01-JAN-20','DD-MON-YY'), 61);
INSERT INTO A4_orders
VALUES (DEFAULT, 1, 'Y', TO_DATE('01-APR-19','DD-MON-YY'), 64);
INSERT INTO A4_orders
VALUES (DEFAULT, 2, 'Y', TO_DATE('05-MAR-16','DD-MON-YY'), 66);
INSERT INTO A4_orders
VALUES (DEFAULT, 1, 'N', TO_DATE('07-NOV-19','DD-MON-YY'), 61);
INSERT INTO A4_orders
VALUES (DEFAULT, 3, 'Y', TO_DATE('15-APR-20','DD-MON-YY'), 70);
INSERT INTO A4_orders
VALUES (DEFAULT, 3, 'N', TO_DATE('01-JAN-16','DD-MON-YY'), 69);
INSERT INTO A4_orders
VALUES (DEFAULT, 4, 'N', TO_DATE('21-DEC-20','DD-MON-YY'), 66);
INSERT INTO A4_orders
VALUES (DEFAULT, 5, 'Y', TO_DATE('21-DEC-19','DD-MON-YY'), 67);
INSERT INTO A4_orders
VALUES (DEFAULT, 6, 'Y', TO_DATE('21-DEC-20','DD-MON-YY'), 68);
INSERT INTO A4_orders
VALUES (DEFAULT, 7, 'N', TO_DATE('21-JAN-20','DD-MON-YY'), 61);
INSERT INTO A4_orders
VALUES (DEFAULT, 7, 'Y', TO_DATE('22-JAN-20','DD-MON-YY'), 64);
INSERT INTO A4_orders
VALUES (DEFAULT, 3, 'N', TO_DATE('23-JAN-20','DD-MON-YY'), 68);
INSERT INTO A4_orders
VALUES (DEFAULT, 3, 'N', TO_DATE('23-JAN-20','DD-MON-YY'), 65);
INSERT INTO A4_orders
VALUES (DEFAULT, 8, 'Y', TO_DATE('11-JUL-19','DD-MON-YY'), 63);
INSERT INTO A4_orders
VALUES (DEFAULT, 8, 'N', TO_DATE('21-JAN-20','DD-MON-YY'), 62);
INSERT INTO A4_orders
VALUES (DEFAULT, 9, 'N', TO_DATE('21-JAN-20','DD-MON-YY'), 65);
INSERT INTO A4_orders
VALUES (DEFAULT, 9, 'N', TO_DATE('21-JAN-20','DD-MON-YY'), 70);
INSERT INTO A4_orders
VALUES (DEFAULT, 10, 'Y', '01-JAN-17', 62);
INSERT INTO A4_orders
VALUES (DEFAULT, 3, 'N', '01-JAN-19', 65);
INSERT INTO A4_orders
VALUES (DEFAULT, 3, 'N', '01-JUN-20', 67);
INSERT INTO A4_orders
VALUES (DEFAULT, 1, 'N', '01-FEB-19', 69);


INSERT INTO A4_payment
VALUES (DEFAULT, 22, TO_DATE('01-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 21, TO_DATE('13-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 21, TO_DATE('07-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 21, TO_DATE('23-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 21, TO_DATE('23-JUL-20','DD-MON-YY'), 'N');
INSERT INTO A4_payment
VALUES (DEFAULT, 24, TO_DATE('01-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 25, TO_DATE('07-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 26, TO_DATE('13-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 27, TO_DATE('23-JUL-20','DD-MON-YY'), 'N');
INSERT INTO A4_payment
VALUES (DEFAULT, 29, TO_DATE('22-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 30, TO_DATE('01-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 31, TO_DATE('22-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO A4_payment
VALUES (DEFAULT, 31, TO_DATE('13-JUL-20','DD-MON-YY'), 'Y');


INSERT INTO A4_product
VALUES (DEFAULT, 21, 101 , 2.50, 3.00);
INSERT INTO A4_product
VALUES (DEFAULT, 21, 102 , 53.50, 4.00);
INSERT INTO A4_product
VALUES (DEFAULT, 21, 103 , 4.50, 7.00);
INSERT INTO A4_product
VALUES (DEFAULT, 23, 105 , 5.50, 2.00);
INSERT INTO A4_product
VALUES (DEFAULT, 23, 108 , 215.50, 10.00);
INSERT INTO A4_product
VALUES (DEFAULT, 26, 104 , 16.50, 15.00);
INSERT INTO A4_product
VALUES (DEFAULT, 23, 103 , 650, 15.00);
INSERT INTO A4_product
VALUES (DEFAULT, 28, 106 , 200, 15.00);
INSERT INTO A4_product
VALUES (DEFAULT, 27, 102 , 1, 15.00);
INSERT INTO A4_product
VALUES (DEFAULT, 22, 103 , 650, 15.00);
INSERT INTO A4_product
VALUES (DEFAULT, 28, 110 , 2000, 115.00);


INSERT INTO A4_discount
VALUES (DEFAULT, 27 , DEFAULT);
INSERT INTO A4_discount
VALUES (DEFAULT, 22 , DEFAULT);
INSERT INTO A4_discount
VALUES (DEFAULT, 23 , DEFAULT);
INSERT INTO A4_discount
VALUES (DEFAULT, 29 , DEFAULT);
INSERT INTO A4_discount
VALUES (DEFAULT, 25 , DEFAULT);
COMMIT;

-- TEST TABLE CREATION
SELECT * FROM A4_orders;
SELECT * FROM A4_orders WHERE customerid='3';
SELECT * FROM A4_berryfruit;
SELECT * FROM A4_berryfruit WHERE RETAILPRICE < '10' ORDER BY category;

-- TEST SEQUENCE CREATION
INSERT INTO A4_product
VALUES (DEFAULT, 28, 110 , 1, 1.00);
INSERT INTO A4_product
VALUES (DEFAULT, 29, 101 , 0, 0.00);
SELECT * FROM A4_product;


-- INDEX
CREATE INDEX order_idx
ON A4_orders(Orderstatus);

CREATE INDEX fullname_idx
ON A4_customer (LastName, FirstName);

CREATE INDEX zip_idx
ON A4_customer(Postalcode);

SELECT table_name, index_name, index_type
FROM user_indexes;

COMMIT;

-- PROCEDURES

CREATE OR REPLACE PROCEDURE SHIP_COST_PC 
(QNT IN NUMBER, SHIP OUT NUMBER) AS 
BEGIN
    IF QNT > 10 THEN
     SHIP := 19.99;
    ELSE
     SHIP := 1.99;
    END IF;
END SHIP_COST_PC;

DECLARE
    ship_num NUMBER (6,2);
BEGIN
    SHIP_COST_PC( 7, ship_num );
    DBMS_OUTPUT.PUT_LINE('The final shipment cost is ' || ship_num);
END;
    
CREATE OR REPLACE PROCEDURE final_disc_pc
(disc_flag OUT VARCHAR2)
IS
CURSOR mycursor IS
    SELECT orderid, SUM(unit * payedprice) sub
    FROM A4_orders JOIN A4_product USING (orderid)
    GROUP BY orderid;
    disc_value NUMBER(3,2);
BEGIN
 FOR item IN mycursor LOOP
 	IF item.sub > 20000 THEN
           disc_flag := '75% DISCOUNT';
           disc_value := 1.75;
 	ELSIF item.sub > 10000 THEN
 		   disc_flag := '40% DISCOUNT';
           disc_value := 1.40;
    ELSIF item.sub > 1000 THEN
 		   disc_flag := '23% DISCOUNT';
           disc_value := 1.23;
    ELSIF item.sub > 250 THEN
 		   disc_flag := '1% DISCOUNT';
           disc_value := 1.01;
    ELSE
        disc_flag := 'NO DISCOUNT';  
        disc_value := 1.00;
 	END IF;
    IF disc_value IS NOT NULL THEN
INSERT INTO A4_discount
VALUES (DEFAULT, item.orderid, disc_value);
 	END IF;
 	disc_value := NULL;
 END LOOP;
 COMMIT;
END; 

DECLARE
    temp_disc VARCHAR2(20);
BEGIN
    final_disc_pc(temp_disc);
DBMS_OUTPUT.PUT_LINE('The last customer will have ' || temp_disc);
END;
    
    
    
    
-- FUNCTIONS    

CREATE OR REPLACE FUNCTION fruit_size_fn
  (p_price IN NUMBER)
  RETURN VARCHAR2
 IS
  lv_size_txt VARCHAR2(20);
BEGIN
  IF p_price > 10 THEN
     lv_size_txt := 'Big Fruit';
  ELSIF p_price > 5 THEN
     lv_size_txt := 'Medium Fruit';
  ELSE
     lv_size_txt := 'Tiny Fruit';
  END IF;
  RETURN lv_size_txt;
END;

DECLARE
  price_num NUMBER(8,2) := 30.00;
  lv_size_txt VARCHAR2(20);
BEGIN
  lv_size_txt := fruit_size_fn(price_num);
  DBMS_OUTPUT.PUT_LINE('The Berry fruit has ' || lv_size_txt);
END;

SELECT category, fruitcode, fruit_size_fn(RETAILPRICE)
  FROM A4_berryfruit;


--Returns the total payed from customer
CREATE OR REPLACE FUNCTION fruit_total_fn
(order_paid IN NUMBER)
    RETURN NUMBER
IS
	total NUMBER(8,2);
BEGIN
    SELECT SUM(payedprice)
        INTO total
    FROM A4_product
    WHERE orderid = order_paid;
IF total IS NULL THEN
        total := 0;
END IF;               
    RETURN total;
END;

SELECT firstname, fruit_total_fn(orderid) total  
FROM A4_customer JOIN A4_orders 
ON A4_customer.customerid = A4_orders.customerid
WHERE orderstatus = 'Y'
ORDER BY firstname;



-- TRIGGERS

CREATE OR REPLACE TRIGGER display_stock_changes_trg
BEFORE DELETE OR INSERT OR UPDATE ON A4_BERRYFRUIT 
FOR EACH ROW 
WHEN (OLD.stockquantity < NEW.stockquantity) 
DECLARE 
   show_diff NUMBER; 
BEGIN 
   show_diff := :NEW.stockquantity  - :OLD.stockquantity; 
   dbms_output.put_line('Previous Quantity: ' || :OLD.stockquantity); 
   dbms_output.put_line('New stock Amount: ' || :NEW.stockquantity); 
   dbms_output.put_line('Stock difference: ' || show_diff); 
END; 

UPDATE A4_berryfruit 
SET stockquantity = 524
WHERE category = 'CRANBERRIES';

UPDATE A4_berryfruit 
SET stockquantity = 30
WHERE fruitcode = 102;



CREATE OR REPLACE TRIGGER check_stock_trg
    BEFORE INSERT OR UPDATE ON A4_berryfruit
    FOR EACH ROW
BEGIN
    IF :NEW.retailprice < 2.50 THEN
        :NEW.retailprice := 2.99;
    END IF;
END;


UPDATE A4_berryfruit 
SET retailprice = 2
WHERE fruitcode = 110;





