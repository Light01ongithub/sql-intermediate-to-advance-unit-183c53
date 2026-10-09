DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS books;

CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title   TEXT NOT NULL,
    genre   TEXT NOT NULL,
    price   REAL NOT NULL
);

CREATE TABLE sales (
    sale_id   INTEGER PRIMARY KEY,
    book_id   INTEGER NOT NULL,
    quantity  INTEGER NOT NULL,
    sale_date TEXT NOT NULL
);

INSERT INTO books (book_id, title, genre, price) VALUES
    (1, 'The Hobbit', 'Fantasy', 12.50),
    (2, 'Mistborn', 'Fantasy', 10.00),
    (3, 'Gone Girl', 'Mystery', 15.00),
    (4, 'Dune', 'Science Fiction', 20.00),
    (5, 'Pride and Prejudice', 'Romance', 8.00),
    (6, 'Dracula', 'Horror', 9.00);

INSERT INTO sales (sale_id, book_id, quantity, sale_date) VALUES
    (1, 1, 3, '2026-09-01'),
    (2, 2, 8, '2026-09-02'),
    (3, 3, 5, '2026-09-03'),
    (4, 4, 4, '2026-09-04'),
    (5, 3, 7, '2026-09-05'),
    (6, 5, 1, '2026-09-06'),
    (7, 4, 6, '2026-09-07'),
    (8, 5, 3, '2026-09-08');

-- (1) Each sale with its book title, quantity and total price.
SELECT sales.sale_id, books.title, sales.quantity,
       sales.quantity * books.price AS total_price
FROM sales
INNER JOIN books ON sales.book_id = books.book_id
ORDER BY sales.sale_id;

-- (2) Total quantity sold per genre.
SELECT books.genre, SUM(sales.quantity) AS total_quantity
FROM sales
INNER JOIN books ON sales.book_id = books.book_id
GROUP BY books.genre
ORDER BY books.genre;

-- (3) Average sale total per book title.
SELECT books.title, ROUND(AVG(sales.quantity * books.price), 2) AS avg_sale_total
FROM sales
INNER JOIN books ON sales.book_id = books.book_id
GROUP BY books.title
ORDER BY books.title;

-- (4) Only genres where total quantity sold is more than 10.
SELECT books.genre, SUM(sales.quantity) AS total_quantity
FROM sales
INNER JOIN books ON sales.book_id = books.book_id
GROUP BY books.genre
HAVING SUM(sales.quantity) > 10
ORDER BY books.genre;

--the sceconmd commit