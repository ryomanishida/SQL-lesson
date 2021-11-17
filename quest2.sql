1,趣味に映画鑑賞が含まれる社員の名前を一覧で表示せよ。
◯ 10
  select name
  from employees
  where hobby1 = "映画鑑賞"
  or hobby2 = "映画鑑賞"
  or hobby3 = "映画鑑賞"
  ;

A
  SELECT
    name
  FROM
      employees
  WHERE
      '映画鑑賞' IN (hobby1, hobby2, hobby3);



2,趣味1～3を縦に表示せよ。
x 10
  select name, concat(hobby1+hobby2+hobby3) as hobby
  from employees
  ;

A
  SELECT name, hobby1 as hobby from employees
  UNION ALL
  SELECT name, hobby2 from employees
  UNION ALL
  SELECT name, hobby3 from employees;



3,名字が佐藤である社員の、趣味の数を表示せよ


4,同じ趣味を持つ社員の一覧を表示せよ。
なお、氏名リストの並び順は社員番号の昇順で、区切り文字は「, 」とする。
