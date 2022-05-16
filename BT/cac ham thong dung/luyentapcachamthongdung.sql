-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select *
from `subject`
where credit = (select max(credit) from `subject`);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select s.subid,s.subname,m.mark
from `subject` s
join mark m on s.subid=m.subid
where mark = (select max(mark) from mark);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select s.studentid,s.studentname,s.address,s.phone,avg(mark) as "medium_score"
from student s
left join mark m on s.studentid=m.studentid
group by s.studentid,s.studentname
order by avg(mark) desc;