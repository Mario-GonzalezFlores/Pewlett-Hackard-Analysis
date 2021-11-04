-- Create table of retiring employees by title
SELECT e.emp_no,
    e.first_name,
	e.last_name,
	t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Unique retiring employees by title
SELECT DISTINCT ON (emp_no)
emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no asc, to_date desc;

SELeCT * FROM unique_titles;
DROP TABLE unique_titles;

-- Retiring personel by title (gruop by)
SELECT COUNT (emp_no) as count,
title

INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Mentorship elegibility
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	de.from_date,	
    de.to_date,
    t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_employees AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (t.to_date = '9999-01-01')
ORDER BY emp_no ASC;

-- Gender title
SELECT e.emp_no,
	e.gender,
	d.dept_name,
    t.title
INTO emp_gender_dept
FROM employees as e
INNER JOIN dept_employees AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (t.to_date = '9999-01-01')
ORDER BY emp_no ASC;

SELECT * FROM emp_gender_dept;
DROP TABLE emp_gender_dept;


SELECT COUNT (emp_no) as count,
dept_name,
title,
gender

INTO gender_number_dept
FROM emp_gender_dept
GROUP BY dept_name,title, gender
ORDER BY dept_name DESC;

SELECT * FROM gender_number_dept;
DROP TABLE gender_number_dept;