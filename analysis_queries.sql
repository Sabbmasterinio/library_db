/* ==========================================================================
LIBRARY SYSTEM - DATA ANALYSIS QUERIES
Author: Sabbmasterinio

Description: These queries demonstrate intermediate SQL skills including 
             Joins, Aggregations, Subqueries, and Conditional Logic.
==========================================================================
*/
USE library_db;
-- 1. BASIC INVENTORY LIST
-- Shows all books with their authors and category names.
-- Demonstrates: Multiple INNER JOINs.
SELECT 
    b.title AS 'Book Title', 
    a.name AS 'Author', 
    c.name AS 'Genre'
FROM books b
JOIN authors a ON b.author_id = a.id
JOIN categories c ON b.category_id = c.id
ORDER BY b.title ASC;


-- 2. ACTIVE LOANS REPORT
-- Displays all books currently borrowed and by whom.
-- Demonstrates: JOINing 3 tables and filtering for NULL values.
SELECT 
    b.title AS 'Book Title',
    CONCAT(m.first_name, ' ', m.last_name) AS 'Borrower Name',
    l.loan_date AS 'Date Borrowed'
FROM loans l
JOIN books b ON l.book_id = b.id
JOIN members m ON l.member_id = m.id
WHERE l.return_date IS NULL;


-- 3. OVERDUE BOOKS TRACKER (The "Business Logic" Query)
-- Finds books held for more than 14 days with a custom status label.
-- Demonstrates: DATEDIFF, CURRENT_DATE, and CASE statements.
SELECT 
    b.title,
    m.email,
    DATEDIFF(CURRENT_DATE, l.loan_date) AS days_held,
    CASE 
        WHEN DATEDIFF(CURRENT_DATE, l.loan_date) > 30 THEN 'CRITICAL: Over 1 Month'
        WHEN DATEDIFF(CURRENT_DATE, l.loan_date) > 14 THEN 'URGENT: Reminder Needed'
        ELSE 'On Time'
    END AS 'Urgency Level'
FROM loans l
JOIN books b ON l.book_id = b.id
JOIN members m ON l.member_id = m.id
WHERE l.return_date IS NULL 
AND DATEDIFF(CURRENT_DATE, l.loan_date) > 14;


-- 4. AUTHOR PRODUCTIVITY ANALYTICS
-- Calculates how many books each author has in our system.
-- Demonstrates: LEFT JOIN (to show authors with 0 books) and GROUP BY.
SELECT 
    a.name, 
    COUNT(b.id) AS total_books_count
FROM authors a
LEFT JOIN books b ON a.id = b.author_id
GROUP BY a.id, a.name
ORDER BY total_books_count DESC;


-- 5. MOST POPULAR GENRES
-- Identifies which categories are borrowed the most.
-- Demonstrates: Aggregation across 3 tables.
SELECT 
    c.name AS genre, 
    COUNT(l.id) AS total_rentals
FROM categories c
JOIN books b ON c.id = b.category_id
JOIN loans l ON b.id = l.book_id
GROUP BY c.id, c.name
ORDER BY total_rentals DESC;


-- 6. "PROLIFIC" AUTHORS SEARCH (Advanced)
-- Finds authors who have more books than the average author.
-- Demonstrates: Subqueries in a HAVING clause.
SELECT name 
FROM authors 
WHERE id IN (
    SELECT author_id 
    FROM books 
    GROUP BY author_id 
    HAVING COUNT(*) > (SELECT AVG(cnt) FROM (SELECT COUNT(*) as cnt FROM books GROUP BY author_id) as sub)
);