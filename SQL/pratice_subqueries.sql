-- SELECT title, retail FROM books;
-- SELECT retail FROM books WHERE title ='DATABASE IMPLEMENTATION';
SELECT title, retail FROM books WHERE category = 'COMPUTER'
AND retail > (SELECT retail FROM books WHERE title ='DATABASE IMPLEMENTATION');

-- SELECT title, retail from books;
-- SELECT MAX(retail) FROM books;
SELECT title, retail from books WHERE retail = (SELECT MAX(retail) FROM books);
SELECT title, retail, (SELECT MAX(retail) FROM books) max from books;

/* List title of all books published by publisher of 'Big Bear and Little Dove'
that generate more than the average profit

--SELECT b.title, p.name FROM books b JOIN publisher p USING (pubid);
--SELECT AVG(retail-cost) profit from books; 
retail-cost > (SELECT AVG(retail-cost) profit from books)
*/
SELECT title FROM books
WHERE pubid = (SELECT pubid from books WHERE title = 'BIG BEAR AND LITTLE DOVE')
AND retail-cost > (SELECT AVG(retail-cost) profit from books);

SELECT isbn, title FROM books 
WHERE pubid =(SELECT pubid FROM books WHERE title = 'SHORTEST POEMS')
AND retail-cost > (SELECT AVG(retail-cost) FROM books);


--calculate the average profit for all 'Literature' books.
SELECT AVG(retail-cost) from books 
WHERE category = 'LITERATURE';

--calculate average per category
SELECT AVG(retail-cost), category FROM books
GROUP by category;

SELECT AVG(retail-cost), category FROM books
GROUP by category HAVING AVG(retail-cost) > 
(SELECT AVG(retail-cost) from books 
WHERE category = 'LITERATURE');

/* Compare the price of each book in inventory
against average price of all books in inventory.

1. calculare avg cost of all book
2. select cost each book.
3. put as same table.
*/
SELECT title, cost, (SELECT AVG(cost) from books)
FROM books;

-- List the difference between each book price and the average

SELECT title, cost, ABS(cost-(SELECT AVG(cost) from books)) dif
FROM books;

--Determine the (retail) price of the 
--most expensive book in each category
SELECT category, max(retail) from books 
GROUP BY category; 







