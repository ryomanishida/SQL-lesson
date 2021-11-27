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