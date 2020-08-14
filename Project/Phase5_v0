/* CREATE TABLES */

CREATE TABLE supplier
(supplierid NUMBER(4,0),
supplierfirstname VARCHAR2(30),
supplierlastname VARCHAR2(30),
address VARCHAR2(100),
state CHAR(2),
postalcode VARCHAR2(6),
email VARCHAR2(30),
phone NUMBER(10,0),
deliveryorder CHAR(1),
CONSTRAINT supplier_supplierid_pk PRIMARY KEY(supplierid),
CONSTRAINT supplier_deliveryorder_ck check(deliveryorder='Y' OR deliveryorder='N')); 

CREATE TABLE customer
(branchorderid NUMBER(4,0),
firstname VARCHAR2(30),
lastname VARCHAR2(30),
address VARCHAR2(100),
state CHAR(2),
postalcode VARCHAR2(6),
email VARCHAR2(30),
phone NUMBER(10,0),
CONSTRAINT customer_branchorderid_pk PRIMARY KEY(branchorderid));

CREATE TABLE shipment 
(shipmentid NUMBER(4,0), 
shipAddress VARCHAR2(100), 
shipPostalCode VARCHAR2(6), 
shipState CHAR(2), 
shipCity VARCHAR2(15), 
shipCost NUMBER(6,2), 
CONSTRAINT shipment_shipmentid_pk PRIMARY KEY (shipmentid));

CREATE TABLE orders
(orderid NUMBER(4,0),
branchorderid NUMBER(4,0),
orderstatus CHAR(1),
orderdate DATE,
shipmentid NUMBER(4,0),
CONSTRAINT orders_orderid_pk PRIMARY KEY(orderid),
CONSTRAINT orders_branchorderid_fk FOREIGN KEY(branchorderid) REFERENCES customer(branchorderid),
CONSTRAINT orders_orderstatus_ck CHECK(orderstatus='Y' OR orderstatus='N'),
CONSTRAINT orders_shipmentid_fk FOREIGN KEY(shipmentid) REFERENCES shipment (shipmentid));

CREATE TABLE paymentorder
(paymentid NUMBER(4,0),
orderid NUMBER(4,0),
paymentduedate DATE,
paymentstatus CHAR(1),
CONSTRAINT porder_paymentid_pk PRIMARY KEY(paymentid),
CONSTRAINT porder_orderid_fk FOREIGN KEY(orderid) REFERENCES orders(orderid),
CONSTRAINT porder_paymentstatus_ck CHECK(paymentstatus='Y' OR paymentstatus='N'));

CREATE TABLE manager
(managerid NUMBER(4,0), 
firstname VARCHAR2(30), 
lastname VARCHAR2(30), 
password CHAR(8), 
CONSTRAINT manager_managerid_pk PRIMARY KEY (managerid));

CREATE TABLE berryfruit
(fruitcode NUMBER(4,0),
category VARCHAR2(20),
stockquantity NUMBER(6,2),
retailprice NUMBER(8,2),
managerid NUMBER(4,0),
constraint berryfruit_fruitcode_pk PRIMARY KEY (fruitcode),
constraint berryfruit_managerid_fk FOREIGN KEY (managerid)REFERENCES manager (managerid));

CREATE TABLE product 
(productid NUMBER(4,0), 
orderid NUMBER(4,0), 
fruitcode NUMBER(4,0), 
unit NUMBER(6,2), 
payedprice NUMBER(8,2), 
CONSTRAINT product_productid_pk PRIMARY KEY (productid), 
CONSTRAINT product_orderid_fk FOREIGN KEY (orderID) REFERENCES orders (orderid), 
CONSTRAINT product_fruitcode_fk FOREIGN KEY (fruitcode) REFERENCES berryfruit (fruitcode));

CREATE TABLE inventorycustomer 
( branchorderid NUMBER(4,0), 
managerid NUMBER(4,0), 
CONSTRAINT invcust_branch_manageid_pk PRIMARY KEY (branchorderid, managerid)); 

CREATE TABLE inventorysupplier 
(supplierid NUMBER(4,0), 
managerid NUMBER(4,0), 
CONSTRAINT invsup_supid_managid_pk PRIMARY KEY (supplierid, managerid));

/* INSERT DATA */

INSERT INTO supplier
VALUES (1001, 'PAUL', 'SMITH', '937 PROGRESS AVENUE', 'ON', 'M7L0C4', 'paul@gmail.com', 6475738513, 'N');
INSERT INTO supplier
VALUES (1002, 'MARY', 'PIERSON', '851 ELSMERE AVENUE', 'QB', 'H3Y0A7', 'mary@gmail.com', 4385738333, 'Y');
INSERT INTO supplier
VALUES (1003, 'JESUS', 'MCCOWAN', '324 SHEPPARD AVENUE', 'OT', 'K2R0C3', 'jesus@gmail.com', 8195757913, 'N');
INSERT INTO supplier
VALUES (1004, 'PETER', 'GIRARD', '145 LAWRENCE AVENUE', 'QB', 'G1N0B2', 'peter@gmail.com', 5145737753, 'Y');
INSERT INTO supplier
VALUES (1005, 'JAMES', 'THOMPSON', '778 YOUNG AVENUE', 'BC', 'V6A0C1', 'james@gmail.com', 2505734447, 'N');
INSERT INTO supplier
VALUES (1006, 'JOHN', 'MCKENZIE', '447 LONG ROAD AVENUE', 'MN', 'R3A0B5', 'john@gmail.com', 2045738577, 'Y');

INSERT INTO customer
VALUES (7001, 'JHOSUA', 'OBAMA', '547 BLOOR ST.', 'ON', 'M7L1C5', 'jhosua@gmail.com', 6475738778);
INSERT INTO customer
VALUES (7002, 'ANDREA', 'KENNETH', '771 ABBEY ROAD', 'QB', 'H3Y3A7', 'andrea@gmail.com', 4385797653);
INSERT INTO customer
VALUES (7003, 'JACOB', 'MESHIA', '114 GREAT JONES ST.', 'OT', 'K2R7C2', 'jacob@gmail.com', 5195009813);
INSERT INTO customer
VALUES (7004, 'DAVID', 'WILLIAM', '985 BOWERY AVENUE', 'OT', 'K2R4C2', 'david@gmail.com', 5145737123);
INSERT INTO customer
VALUES (7005, 'GEORGE', 'LEE', '138 VICTORIA AVENUE', 'BC', 'V6A9C0', 'george@gmail.com', 2505790897);
INSERT INTO customer
VALUES (7006, 'CLAIR', 'NELSON', '447 CAMBRAI AVENUE', 'MN', 'R3A1B7', 'clair@gmail.com', 2045738954);

INSERT INTO shipment
VALUES (4001, '1257 PROGRES AVENUE.', 'M7L1A9', 'ON','SCARBOROUGH', 34.50);
INSERT INTO shipment
VALUES (4002, '7895 SOUTH AVENUE', 'H3Y3B3', 'QB', 'MONTREAL', 15.50);
INSERT INTO shipment
VALUES (4003, '789 DIRT ROAD', 'K2R7A1','OT', 'OTAWA', 23.55);
INSERT INTO shipment
VALUES (4004, '4732 MAIN STREET', 'K2R4B2', 'OT', 'OTAWA', 32.75);
INSERT INTO shipment
VALUES (4005, '3478 EAGLE AVENUE', 'V6A9B7', 'BC', 'VANCOUVER', 42.37);
INSERT INTO shipment
VALUES (4006, '8937 LONG AVENUE', 'R3A1A4', 'MN','WINNIPEG', 39.55);

INSERT INTO orders
VALUES (2001, 7005, 'Y', TO_DATE('31-JAN-20','DD-MON-YY'), 4005);
INSERT INTO orders
VALUES (2002, 7002, 'Y', TO_DATE('21-APR-19','DD-MON-YY'), 4002);
INSERT INTO orders
VALUES (2003, 7005, 'N', TO_DATE('15-MAR-20','DD-MON-YY'), 4005);
INSERT INTO orders
VALUES (2004, 7003, 'N', TO_DATE('07-NOV-19','DD-MON-YY'), 4003);
INSERT INTO orders
VALUES (2005, 7005, 'Y', TO_DATE('05-APR-20','DD-MON-YY'), 4004);
INSERT INTO orders
VALUES (2006, 7004, 'Y', TO_DATE('21-JAN-20','DD-MON-YY'), 4005);

INSERT INTO paymentorder
VALUES (5001, 2005, TO_DATE('31-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO paymentorder
VALUES (5002, 2006, TO_DATE('23-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO paymentorder
VALUES (5003, 2001, TO_DATE('30-JUN-20','DD-MON-YY'), 'Y');
INSERT INTO paymentorder
VALUES (5004, 2002, TO_DATE('01-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO paymentorder
VALUES (5005, 2003, TO_DATE('02-JUL-20','DD-MON-YY'), 'Y');
INSERT INTO paymentorder
VALUES (5006, 2004, TO_DATE('02-JUL-20','DD-MON-YY'), 'Y');

INSERT INTO inventorysupplier
VALUES (1001, 9001);
INSERT INTO inventorysupplier
VALUES (1002, 9002);
INSERT INTO inventorysupplier
VALUES (1003, 9003);
INSERT INTO inventorysupplier
VALUES (1004, 9004);
INSERT INTO inventorysupplier
VALUES (1006, 9005);
INSERT INTO inventorysupplier
VALUES (1005, 9006);

INSERT INTO inventorycustomer
VALUES (7001, 9001);
INSERT INTO inventorycustomer
VALUES (7002, 9002);
INSERT INTO inventorycustomer
VALUES (7003, 9003);
INSERT INTO inventorycustomer
VALUES (7004, 9004);
INSERT INTO inventorycustomer
VALUES (7006, 9005);
INSERT INTO inventorycustomer
VALUES (7005, 9006);

INSERT INTO manager
VALUES (9001, 'JOSHUA', 'EAGLES', NULL); 
INSERT INTO manager
VALUES (9002, 'STEPHEN', 'KNOWN', NULL); 
INSERT INTO manager
VALUES (9003, 'ANDREA', 'PINEDA', NULL); 
INSERT INTO manager
VALUES (9004, 'RAPHAEL', 'COELHO', NULL); 
INSERT INTO manager
VALUES (9005, 'LUANA', 'CESAR', NULL); 
INSERT INTO manager
VALUES (9006, 'JOHN', 'SNOW', NULL); 

INSERT INTO BERRYFRUIT
VALUES (3001, 'BLUEBERRIES', 1000, 5.50, 9001);
INSERT INTO BERRYFRUIT
VALUES (3002, 'RASPBERRIES', 3000, 9.60, 9002);
INSERT INTO BERRYFRUIT
VALUES (3003, 'GOJIBERRIES', 5000, 10.00, 9003);
INSERT INTO BERRYFRUIT
VALUES (3004, 'STRAWBERRIES', 9000, 15.50, 9004);
INSERT INTO BERRYFRUIT
VALUES (3005, 'CRANBERRIES', 500, 12.60, 9005);
INSERT INTO BERRYFRUIT
VALUES (3006, 'ACAIBERRIES', 500, 20.00, 9006);

INSERT INTO PRODUCT
VALUES (6001, 2001, 3001 , 2.50, 3.00);
INSERT INTO PRODUCT
VALUES (6002, 2002, 3002 , 3.50, 4.00);
INSERT INTO PRODUCT
VALUES (6003, 2003, 3003 , 4.50, 7.00);
INSERT INTO PRODUCT
VALUES (6004, 2004, 3004 , 5.50, 2.00);
INSERT INTO PRODUCT
VALUES (6005, 2005, 3005 , 15.50, 10.00);
INSERT INTO PRODUCT
VALUES (6006, 2006, 3006 , 16.50, 15.00);
 
/* SQL QUERIES */

SELECT firstname, lastname, orderdate
FROM customer c, orders o
WHERE c.branchorderid = o.branchorderid
        AND orderstatus='N';

SELECT lastname, SUM(shipcost)
FROM customer JOIN orders USING (branchorderid)
JOIN shipment USING (shipmentid)
GROUP BY lastname
HAVING SUM(shipcost)>20;

SELECT firstname, lastname, orderid, orderdate
FROM customer NATURAL JOIN orders
WHERE orderid IN ('2001' , '2004')
ORDER BY firstname DESC;

SELECT o.orderdate, p.unit, bf.category
FROM orders o JOIN product p ON o.orderid = p.orderid
JOIN berryfruit bf ON p.fruitcode = bf.fruitcode
WHERE bf.retailprice > 6.50;

SELECT c.firstname, o.orderdate, p.fruitcode , bf.managerid
FROM customer c JOIN orders o ON c.branchorderid = o.branchorderid
JOIN product p ON o.orderid = p.orderid
JOIN berryfruit bf ON p.fruitcode = bf.fruitcode
WHERE category LIKE '%BERR%';

SAVEPOINT ONE; 

SELECT managerid, password
FROM manager 
WHERE password IS NULL;

SELECT INITCAP(firstname) FROM customer
WHERE state = 'ON';

SELECT category, AVG(retailprice)
FROM berryfruit
GROUP BY category;

SELECT firstname, category
FROM customer CROSS JOIN berryfruit;

DESCRIBE SESSION_PRIVS;

COMMIT;





