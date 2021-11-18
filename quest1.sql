理解度1~10

1,性別が男である生徒の名前を一覧で表示せよ。
◯　10
  select name
  from students
  where gender = '男';


2,1教科でも30点以下の点数を取った生徒の名前を一覧で表示せよ。
ただし、重複は許さないものとする。
◯　10
  select distinct(name)
  from students s
  join exam_results er
  on s.id = er.student_id
  where score <= 30;


3,性別ごとに、最も高かった試験の点数を表示せよ。
x　8
  select gender, max(er.score)
  from students s
  join exam_results er
  on s.id = er.student_id
  group by gender
  having max(score);

◯
  select s.gender, max(er.score) as "最高得点"
  from exam_results er
  join students s
  on er.student_id = s.id
  group by s.gender
  ;


A
  SELECT
      s.gender,
      MAX(er.score) AS max_score
  FROM
      students s
  INNER JOIN exam_results er
      ON s.id = er.student_id
  GROUP BY
      s.gender


4,教科ごとの試験の平均点が50点以下である教科を表示せよ。
◯　8
  select subject
  from exam_results
  group by subject
  having 50 >= avg(score)
  ;


5,試験結果テーブルの点数の右に、その教科の平均点を表示せよ。
x  7
  select *, avg(score) as "平均点"
  from exam_results
  group by subject
  having avg(score)
  and
  ;

x
select er1.*, (
  select avg(er2.score) as "平均点"
  from exam_results er2
  group by subject
  ;)
from exam_results er1
;

A
  SELECT er1.*, (
    SELECT AVG(er2.score)
    FROM exam_results er2
    WHERE er1.subject = er2.subject
    ) AS subject_avg_score
  FROM exam_results er1;


6,試験結果に理科が含まれない生徒の名前を一覧で表示せよ。
x  5
  select distinct(name)
  from students s
  join exam_results er
  on s.id = er.student_id
  where not er.subject like "%理科%"
  ;

x　理科が含まれない値だけ除去 != 理科が含まれない生徒
  select distinct(s.name)
  from students s
  join exam_results er
  on s.id = er.student_id
  where not subject = "理科"
;

A1
  select name
  from students
  where id not in(
    select student_id
    from exam_results
    where subject = '理科'
  );

A2
  select name
  from students score
  where not exists(
    select *
    from exam_results
    where subject = "理科"
    and student_id = s.id
  );




brew services start mysql