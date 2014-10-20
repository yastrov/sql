/*
Найти книги, которые повторяются в базе данных 2 и более раза
(одно и то же название, принадлежащих одному автору.
Вывод: автор, название книги, количество повторений.
Debugging with Sqliteman (GUI for SQLite)
Author: Yuri Astrov
*/
CREATE TABLE "books" (
    "title" TEXT NOT NULL,
    "author_id" INTEGER,
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
);
CREATE TABLE "authors" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "name" TEXT NOT NULL,
    "lastname" TEXT
);
CREATE TABLE sqlite_sequence(name,seq);

-- For other databases: replace '||' to '+'
SELECT (authors.lastname||" "||authors.name), t.title, t.num  AS "Count_of_books"
FROM
  (SELECT Count(title) AS num,
          author_id,
          title
   FROM books
   GROUP BY author_id) AS t
JOIN authors ON authors.id=t.author_id
WHERE t.num>=2;

/*DOUBLE OUTPUT: print for each of books:*/
SELECT (authors.lastname||" "||authors.name), title, books.id
FROM books
LEFT OUTER JOIN authors ON authors.id=books.author_id
WHERE books.title IN
    (SELECT title
     FROM books
     GROUP BY author_id,
              title HAVING COUNT(title)>1);
