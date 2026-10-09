CREATE TEMP TABLE results (test TEXT, passed INTEGER);

INSERT INTO results VALUES ('at least 8 sales rows',
    (SELECT COUNT(*) >= 8 FROM sales));

INSERT INTO results VALUES ('at least 5 books rows',
    (SELECT COUNT(*) >= 5 FROM books));

INSERT INTO results VALUES ('every sale matches a book',
    (SELECT COUNT(*) = 0 FROM sales
        WHERE book_id NOT IN (SELECT book_id FROM books)));

INSERT INTO results VALUES ('printed results match tests/expected_output.txt',
    (SELECT rtrim(replace(readfile('tests/actual_output.txt'), char(13), ''), char(10))
            = rtrim(replace(readfile('tests/expected_output.txt'), char(13), ''), char(10))));

SELECT CASE WHEN passed = 1 THEN 'PASS' ELSE 'FAIL' END || ': ' || test
FROM results;

SELECT SUM(passed = 1) || ' passed, ' || SUM(passed IS NOT 1) || ' failed'
FROM results;

CREATE TEMP TABLE all_tests_pass (failed INTEGER CHECK (failed = 0));
INSERT INTO all_tests_pass SELECT COUNT(*) FROM results WHERE passed IS NOT 1;