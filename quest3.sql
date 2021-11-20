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


4,相互フォローしているユーザーのIDを表示せよ。なお、重複は許さないものとする。