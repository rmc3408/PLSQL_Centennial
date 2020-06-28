
-- Question 01
CREATE VIEW contact
AS SELECT name, contact FROM publisher;


-- Question 02
CREATE OR REPLACE VIEW contact
AS SELECT name, contact FROM publisher WITH READ ONLY;


-- Question 03
CREATE FORCE VIEW homework13
AS SELECT col1, col2 FROM firstattempt;


-- Question 04
DESC homework13;


-- Question 05
CREATE VIEW reorderinfo
AS SELECT b.isbn, b.title, p.name, p.phone FROM books b JOIN publisher p USING (pubID);
--To alter view.
CREATE OR REPLACE VIEW reorderinfo
AS SELECT b.isbn, b.title, p.contact, p.phone FROM books b JOIN publisher p USING (pubID);


-- Question 06
UPDATE reorderinfo
SET contact = 'Raphael'
WHERE contact = 'RENEE SMITH';
-- Note: primary key from PUBLISHER isn’t in the view.


-- Question 07
UPDATE reorderinfo
SET isbn = '040014000'
WHERE title = 'REVENGE OF MICKEY';
-- Note: ISBN has constraint.


-- Question 08
DELETE FROM reorderinfo
WHERE contact = 'RENEE SMITH';
--Note: The have Primary key connect to other table.


-- Question 09
ROLLBACK;


-- Question 10
DROP VIEW reorderinfo;
