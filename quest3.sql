1,さくらがフォローしているユーザーの名前を一覧で表示せよ。
x  5
SELECT follower_id
FROM follows
WHERE followee_id = (
  SELECT id
  FROM users
  WHERE name = "さくら"
);

SELECT u2.name
FROM users u1
JOIN follows f
ON u1.id = f.follower_id
JOIN users u2
ON f.followee_id = u2.id
WHERE u1.id = 3;


2,誰もフォローしていないユーザーの名前を表示せよ。
X  8
SELECT u.name
FROM users u
JOIN follows f
ON u.id = f.follower_id
WHERE f.followee_id is null;

A
SELECT u.name
FROM users u
LEFT JOIN follows f
ON u.id = f.follower_id
WHERE f.followee_id IS NULL;



3,10代、20代、30代といった年代別にフォロー数の平均を表示せよ。
X  4
SELECT 
  CASE 
    WHEN age IN ('10','11','12','13','14','15','16','17','18','19') THEN "10代"
    WHEN age IN ('20','21','22','23','24','25','26','27','28','29') THEN "20代"
    WHEN age IN ('30','31','32','33','34','35','36','37','38','39') THEN "30代"
  END, avg(*) AS 平均人数
FROM users
GROUP BY 
  CASE 
    WHEN age IN ('10','11','12','13','14','15','16','17','18','19') THEN "10代"
    WHEN age IN ('20','21','22','23','24','25','26','27','28','29') THEN "20代"
    WHEN age IN ('30','31','32','33','34','35','36','37','38','39') THEN "30代"
  END;

A
  SELECT
    CONCAT(age_group * 10, '代') AS age_group,
    AVG(count) AS avg_count
  FROM (
      SELECT
          FLOOR(age / 10) AS age_group,
          count(f.follower_id) AS count
      FROM
          users u
      LEFT JOIN follows f
          ON u.id = f.follower_id
      GROUP BY
          u.id
  ) follows_count
  GROUP BY
      age_group

-- FLOOR(数値)で小数点以下を切り捨て
-- LEFT JOIN, RIGHT JOIN　 は値がなく、結合できない情報も優先テーブルに指定して表示する



4,相互フォローしているユーザーのIDを表示せよ。なお、重複は許さないものとする。

X  5
SELECT distinct(f1.followee_id) AS id1, distinct(f2.follower_id) AS id2
FROM follows f1
JOIN follows f2
ON f1.follower_id = f2.followee_id
;


A
SELECT 
    f1.follower_id As id1,
    f1.followee_id As id2
FROM
    follows f1
INNER JOIN follows f2
    ON f1.follower_id = f2.followee_id
    AND f1.followee_id = f2.follower_id
WHERE
    f1.follower_id < f1.followee_id