SELECT customer# from Customers;
SELECT * from CUSTOMERS;

-- Check all sequences 
SELECT * FROM user_sequences;

-- Remove Sequence
DROP SEQUENCE customers_customerID_seq;


-- Question 01
CREATE SEQUENCE customers_customerID_seq
INCREMENT BY 1
START WITH 1021;


-- Question 02
INSERT INTO CUSTOMERS (customer#, lastname, firstname, zip)
VALUES (customers_customerID_seq.NEXTVAL, 'Shoulders', 'Frank', 23567); 


-- Question 03
CREATE SEQUENCE my_first_seq
INCREMENT BY 3 START WITH 5;

