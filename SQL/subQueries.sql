--Question 01
SELECT title, retail FROM books
WHERE retail < (SELECT AVG(retail) FROM books);


--Question 02
SELECT a.title, b.category, a.cost FROM books a, 
(SELECT category, AVG(cost) average FROM books GROUP BY category) b
WHERE a.category = b.category 
and a.cost < b.average;


--Question 03
SELECT order# from orders
WHERE shipstate = (SELECT shipstate
FROM orders WHERE order#=1014);


--Question 04
SELECT order#, SUM(quantity * paideach)
FROM orderitems
GROUP BY order#
HAVING SUM(quantity * paideach) >
(SELECT SUM(quantity * paideach)
FROM orderitems
WHERE order# = 1008);


--Question 05
SELECT lname, fname
FROM bookauthor JOIN author USING(authorid)
WHERE isbn IN
(SELECT isbn
FROM orderitems
GROUP BY isbn
HAVING SUM(quantity) =
(SELECT MAX(COUNT(*))
FROM orderitems
GROUP BY isbn));

--Question 06
SELECT title from books 
WHERE category IN (SELECT DISTINCT category FROM books
JOIN orderitems using (isbn)
JOIN orders using (order#) 
WHERE customer# = 1007)
AND isbn NOT IN (SELECT isbn FROM orders
JOIN orderitems using (order#) 
WHERE customer# = 1007);


--Question 07
SELECT shipcity, shipstate
FROM orders
WHERE shipdate-orderdate =
(SELECT MAX(shipdate-orderdate)
FROM orders);



--Question 08
SELECT customer#
FROM customers JOIN orders USING(customer#) JOIN orderitems USING(order#) JOIN books USING(isbn)
WHERE retail =
(SELECT MIN(retail)
FROM books);


--Question 09
SELECT COUNT(DISTINCT customers#)
FROM orders JOIN orderitems USING(order#)
WHERE isbn IN
(SELECT isbn
FROM orderitems JOIN bookauthor USING(isbn)
JOIN author USING(authorid)
WHERE lname= 'AUSTIN'
AND fname = 'JAMES');


--Question 10
SELECT title
FROM books
WHERE pubid =
(SELECT pubid
FROM books
WHERE title = 'THE WOK WAY TO COOK');
