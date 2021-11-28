-- worldcup2014より
1,各グループの中でFIFAランクが最も高い国と低い国のランキング番号を表示してください。
◯
SELECT group_name, MAX(ranking) AS 最下位, MIN(ranking) AS 1位
FROM countries
GROUP BY group_name;

2,全ゴールキーパーの平均身長、平均体重を表示してください
◯
SELECT AVG(height), AVG(weight)
FROM players p
WHERE position = 'GK';

3,各国の平均身長を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
X
SELECT c.name, AVG(p.height) DESC
FROM countries c
JOIN players p
ON c.id = p.country_id
GROUP BY c.name;

A
SELECT c.name AS 国名, AVG(p.height) AS 平均身長
FROM countries c
JOIN players p ON p.country_id = c.id
GROUP BY c.id, c.name
ORDER BY AVG(p.height) DESC

4,各国の平均身長を高い方から順に表示してください。
ただし、FROM句はplayersテーブルとして、テーブル結合を使わず副問合せを用いてください。
SELECT c.name AS 国名, AVG(p.height) AS 平均身長
FROM players p
GROUP BY p.country_id
ORDER BY AVG(p.height) desc;
HAVING country_id = (
  SELECT c.id
  FROM countries c
);

SELECT (
  SELECT c.name
  FROM countries c
  WHERE p.country_id = c.id
  ) AS 国名, AVG(p.height) AS 平均身長
FROM players p
GROUP BY p.country_id
ORDER BY AVG(p.height) DESC;

5,キックオフ日時と対戦国の国名をキックオフ日時の早いものから順に表示してください。
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

6,すべての選手を対象として選手ごとの得点ランキングを表示してください（SELECT句で副問合せを使うこと）