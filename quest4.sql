-- worldcup2014より
-- 1,各グループの中でFIFAランクが最も高い国と低い国のランキング番号を表示してください。
-- ◯
-- SELECT group_name, MAX(ranking) AS 最下位, MIN(ranking) AS 1位
-- FROM countries
-- GROUP BY group_name;


-- 2,全ゴールキーパーの平均身長、平均体重を表示してください
-- ◯
-- SELECT AVG(height), AVG(weight)
-- FROM players p
-- WHERE position = 'GK';

-- 3,各国の平均身長を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
-- X
-- SELECT c.name, AVG(p.height) DESC
-- FROM countries c
-- JOIN players p
-- ON c.id = p.country_id
-- GROUP BY c.name
-- ;

-- X
-- SELECT c.name,(
--   SELECT AVG(p.height) AS 平均身長
--   FROM players p
--   WHERE c.id = p.country_id
--   GROUP BY c.id
--   ORDER BY AVG(p.height) DESC
--   )
-- FROM countries c
-- ;

-- ◯
-- SELECT c.name,avg(p.height)
-- FROM countries c
-- JOIN players p ON c.id = p.country_id
-- GROUP BY c.id
-- ORDER BY avg(p.height) desc
-- ;

-- ◯
-- SELECT c.name as 国名, avg(p.height) as 平均身長
-- FROM countries c
-- JOIN players p ON c.id = p.country_id
-- GROUP BY c.id
-- ORDER BY 平均身長 desc
-- ;

-- A
-- SELECT c.name AS 国名, AVG(p.height) AS 平均身長
-- FROM countries c
-- JOIN players p ON p.country_id = c.id
-- GROUP BY c.id, c.name
-- ORDER BY AVG(p.height) DESC


-- 4,各国の平均身長を高い方から順に表示してください。
-- ただし、FROM句はplayersテーブルとして、テーブル結合を使わず副問合せを用いてください。
-- X
-- SELECT c.name AS 国名, AVG(p.height) AS 平均身長
-- FROM players p
-- GROUP BY p.country_id
-- ORDER BY AVG(p.height) desc;
-- HAVING country_id = (
--   SELECT c.id
--   FROM countries c
-- );

-- X
-- SELECT AVG(p.height) AS 平均身長, (
--   SELECT c.name
--   FROM countries c
--   WHERE c.id = p.country_id
--   )
-- FROM players p
-- GROUP BY p.country_id
-- ORDER BY AVG(p.height) DESC;

-- ◯
-- SELECT avg(p.height) as 平均身長,(
--   select c.name
--   from countries c
--   where c.id = p.country_id
-- ) as 国名
-- FROM players p
-- GROUP BY p.country_id
-- ORDER BY 平均身長 DESC
-- ;

-- A
-- SELECT (
--   SELECT c.name
--   FROM countries c
--   WHERE p.country_id = c.id
--   ) AS 国名, AVG(p.height) AS 平均身長
-- FROM players p
-- GROUP BY p.country_id
-- ORDER BY AVG(p.height) DESC;


-- 5,キックオフ日時と対戦国の国名をキックオフ日時の早いものから順に表示してください。
X
SELECT p.kickoff, (
  SELECT c.name
  FROM countries c
  WHERE c.country_id = p.id
  ) AS 国名
FROM pairings p
ORDER BY p.kickoff ASC;

◯
SELECT p.kickoff, c1.name AS 国名1, c2.name AS 国名2
FROM pairings p
JOIN countries c1
ON p.my_country_id = c1.id
JOIN countries c2
ON p.enemy_country_id = c2.id
ORDER BY p.kickoff ASC;

A
SELECT kickoff AS キックオフ日時, c1.name AS 国名1, c2.name AS 国名2
FROM pairings p
LEFT JOIN countries c1 ON p.my_country_id = c1.id
LEFT JOIN countries c2 ON p.enemy_country_id = c2.id
ORDER BY kickoff


-- 6,すべての選手を対象として選手ごとの得点ランキングを表示してください（SELECT句で副問合せを使うこと）
X
SELECT p.name AS 選手名, (
  SELECT count(g.player_id) AS 得点数
  FROM goals g
  WHERE p.id = g.player_id
  GROUP BY g.player_id
  ORDER BY count(g.player_id) desc
  )
FROM players p;

◯
SELECT p.name as 選手,(
  select count(g.id)
  from goals g
  where g.player_id = p.id
) as ゴール数
from players p
ORDER by ゴール数 desc
;

A
SELECT p.name AS 名前, p.position AS ポジション, p.club AS 所属クラブ,(
  SELECT COUNT(id)
  FROM goals g
  WHERE g.player_id = p.id
  ) AS ゴール数
FROM players p
ORDER BY ゴール数 DESC


SELECT p.name, (
  select count(g.id)
  from goals g
  where g.player_id = p.id
) as ゴール数
from players p
ORDER by ゴール数 desc;

-- 7,すべての選手を対象として選手ごとの得点ランキングを表示してください。（テーブル結合を使うこと）
◯
SELECT p.name AS 選手名, p.position AS ポジション, count(g.id) AS ゴール数
FROM players p
LEFT JOIN goals g
ON p.id = g.player_id
GROUP BY p.id
ORDER by ゴール数 DESC
;

グループ関数を使っている場合には、SELECT句に書いているカラムはすべてGROUP BY句に記述しなければいけないとうルールあり

SELECT p.name AS 名前, p.position AS ポジション, p.club AS 所属クラブ,
    COUNT(g.id) AS ゴール数
FROM players p
LEFT JOIN goals g ON g.player_id = p.id
GROUP BY p.id, p.name, p.position, p.club
ORDER BY ゴール数 DESC；

-- 8,各ポジションごとの総得点を表示してください。
◯
SELECT p.position AS ポジション, count(g.id) AS ゴール数
FROM players p
LEFT JOIN goals g
ON p.id = g.player_id
GROUP BY p.position
;

-- 9,ワールドカップ開催当時（2014-06-13）の年齢をプレイヤー毎に表示する。
X
SELECT birth, 2021-11-30 - birth, name
FROM players
;

A
SELECT birth, TIMESTAMPDIFF(YEAR, birth, '2021-11-30') AS age, name, position
FROM players
ORDER BY age DESC;

-- 10,オウンゴールの回数を表示する
X
SELECT count()
FROM goals
WHERE player_id =
;

A
SELECT COUNT(g.goal_time)
FROM goals g
WHERE g.player_id IS NULL;

-- 11,各グループごとの総得点数を表示して下さい。
-- SELECT c.group_name, COUNT(g.id)
select c.group_name, count(g.id)
FROM goals g
JOIN pairings p
ON g.pairing_id = p.id
JOIN countries c
ON p.my_country_id = c.id
GROUP BY c.group_name
;

SELECT c.group_name, COUNT(g.id)
FROM goals g
LEFT JOIN pairings p
ON p.id = g.pairing_id
LEFT JOIN countries c
ON p.my_country_id = c.id
WHERE p.kickoff BETWEEN '2014-06-13 0:00:00' AND '2014-06-27 23:59:59'
GROUP BY c.group_name
;

-- BETWEEN >>> ~の間に
BETWEEN [最小値] AND [最大値]

12,日本VSコロンビア戦（pairings.id = 103）でのコロンビアの得点のゴール時間を表示してください
◯
SELECT goal_time
FROM goals g
WHERE pairing_id = 103
;

13,日本VSコロンビア戦の勝敗を表示して下さい。
X
SELECT count(g.id)
FROM goals g
WHERE pairing_id = 103
;
SELECT count(g.id)
FROM goals g
WHERE pairing_id = 39
;

SELECT c.name, COUNT(g.goal_time)
FROM goals g
LEFT JOIN pairings p ON p.id = g.pairing_id
LEFT JOIN countries c ON p.my_country_id = c.id 
WHERE p.id = 103 OR p.id = 39
GROUP BY c.name

-- 14,グループCの各対戦毎にゴール数を表示してください。

SELECT p1.kickoff, c1.name AS my_country, c2.name AS enemy_country,
    c1.ranking AS my_ranking, c2.ranking AS enemy_ranking,
    COUNT(g1.id) AS my_goals
FROM pairings p1
LEFT JOIN countries c1 ON c1.id = p1.my_country_id
LEFT JOIN countries c2 ON c2.id = p1.enemy_country_id
LEFT JOIN goals g1 ON p1.id = g1.pairing_id
WHERE c1.group_name = 'C' AND c2.group_name = 'C'
GROUP BY p1.kickoff, c1.name, c2.name, c1.ranking, c2.ranking
ORDER BY p1.kickoff, c1.ranking