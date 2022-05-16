SELECT * FROM Student
WHERE StudentName like 'h%';

SELECT * FROM Class
WHERE MONTH(Startdate) = 12;

SELECT * FROM Subject
WHERE Credit > 2 AND Credit < 6;

UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';

SELECT S.StudentId S, StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId
ORDER BY Mark DESC;