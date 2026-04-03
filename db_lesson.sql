--課題1
create table departments (
  department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP
);

--課題2
ALTER TABLE people ADD department_id INT UNSIGNED NULL AFTER email;

--課題3
--departments
INSERT INTO departments (name) VALUES
('営業'),
('開発'),
('経理'),
('人事'),
('情報システム');

--people
INSERT INTO people (name, email, department_id, age, gender) VALUES
('田中 太郎', 'tanaka.taro@example.com', 1, 28, 1),
('佐藤 花子', 'sato.hanako@example.com', 1, 32, 2),
('鈴木 一郎', 'suzuki.ichiro@example.com', 1, 45, 1),
('高橋 美咲', 'takahashi.misaki@example.com', 2, 25, 2),
('伊藤 健', 'ito.ken@example.com', 2, 38, 1),
('渡辺 彩', 'watanabe.aya@example.com', 2, 29, 2),
('山本 翔', 'yamamoto.sho@example.com', 2, 34, 1),
('中村 優子', 'nakamura.yuko@example.com', 3, 41, 2),
('小林 大輔', 'kobayashi.daisuke@example.com', 4, 27, 1),
('加藤 里奈', 'kato.rina@example.com', 5, 31, 2);

--reports
INSERT INTO reports (person_id, content) VALUES
(1, '本日は新規ユーザー登録機能の仕様を確認し、画面遷移を整理しました。'),
(2, 'データベース設計のレビューを行い、カラム定義の修正点をまとめました。'),
(3, '既存コードのリファクタリングを行い、可読性の向上を図りました。'),
(4, 'バリデーションエラーの原因を調査し、修正対応を実施しました。'),
(4, 'チームミーティングに参加し、今週のタスクの優先順位を確認しました。'),
(6, 'ログイン処理のテストケースを追加し、正常系と異常系を整理しました。'),
(6, 'API連携部分の動作確認を行い、レスポンス内容を検証しました。'),
(8, '画面レイアウトの微調整を行い、UIのズレを修正しました。'),
(9, 'エラーログを確認し、再現手順と原因の切り分けを行いました。'),
(10, 'SQLクエリのパフォーマンスを確認し、インデックス追加を検討しました。');

--課題4
UPDATE people SET department_id = 1 WHERE department_id IS NULL AND gender = 1;
UPDATE people SET department_id = 2 WHERE department_id IS NULL AND gender = 2;
UPDATE people SET department_id = 3 WHERE department_id IS NULL AND gender IS NULL;

--別解
UPDATE people
SET department_id = CASE
  WHEN gender = 1 THEN 1
  WHEN gender = 2 THEN 2
  ELSE 3
END
WHERE department_id IS NULL;

--課題5
SELECT name, age FROM people WHERE gender = 1 ORDER BY age DESC;

--課題6
peopleテーブルからdepartment_idが1の人(営業に所属している人)のレコードを取得する。
表示するカラムはname,email,age(名前とメールアドレスと年齢)。
但し、created_at(登録日時)の昇順で表示する。

--課題7
SELECT name FROM people WHERE (gender = 2 AND age BETWEEN 20 AND 29) OR (gender = 1 AND age BETWEEN 40 AND 49);

--課題8
SELECT * FROM people JOIN departments USING (department_id) WHERE department_id = 1 ORDER BY age;

--課題9
SELECT AVG(p.age) AS average_age FROM people p JOIN departments d USING (department_id) WHERE department_id = 2 AND p.gender = 2 GROUP BY department_id;
(GROUP BY department_idはなくても結果は同じになった。条件から考えてdepartment_idは2で固定されるため)

--課題10
SELECT p.name, d.name, r.content FROM people p JOIN departments d USING (department_id) RIGHT JOIN reports r USING (person_id);
(日報優先で表示するため、reportsを基準にRIGHT JOINを使用)

--課題11
SELECT p.name FROM people p LEFT JOIN reports r USING (person_id) WHERE r.content IS NULL;
