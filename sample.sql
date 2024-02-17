-- 2-6-3 はじめてのSQL文
SELECT user_id FROM sample.sales

-- 2-7-4 カラムの別名を定義しない場合
SELECT revenue * 0.1 FROM sample.sales

-- 2-7-5 カラムの別名を定義した場合
select revenue * 0.1 as tax from sample.sales

-- 2-7-6 カラムの別名を定義した場合（as を省略）
select revenue * 0.1 tax from sample.sales

-- 2-7-7 コメントの例
select order_id
from sample.sales
where quantity > 3 -- 数量が3より大きい条件での絞り込み
/* revenue での絞り込みはコメントアウト
and revenue > 10000
*/

-- 2-7-8 末尾にセミコロンが必要な例
select quantity from sample.sales;  -- 1つのクエリに2つ以上の文を書く場合は;が必要
select revenue from sample.sales

-- 3-1-1 単一フィールドの値を全行取得する
select order_id from sample.sales

-- 3-1-2 複数の不要なフィールドの値を全行取得する
select order_id, user_id, quantity from sample.sales

-- 3-1-3 並び替えの基準となるフィールドを指定する
select order_id, user_id, quantity
from sample.sales
order by order_id

-- 3-1-4 並び替えの順序を指定する（昇順を明示）
select order_id, user_id, quantity
from sample.sales
order by order_id asc

-- 3-1-5 並び替えの基準と順序を複数指定する
select order_id, user_id, quantity
from sample.sales
order by user_id asc, order_id desc

-- 3-1-6 並べ替えの基準を列番号で指定する
select order_id, user_id, quantity
from sample.sales
order by 1, 2 desc

-- 3-1-8 単一の不要なフィールドを除外して全ての列を取得
select * except (cost)
from sample.products

-- 3-1-9 複数の不要なフィールドを除外して全ての列を取得
select * except (product_id, cost)
from sample.products

-- 3-2-1 新しいフィールドに数値・文字列・日付を格納する
select 100
,"東京"
,"2020-01-01"
from sample.sales

-- 3-2-2 フィールドの値と定数の演算結果を格納する
select order_id, revenue * 1.1
from sample.sales

-- 3-2-3 演算の優先順位を指定する
select (quantity + 2) * 3
from sample.sales

-- 3-2-33 FROM を省略した例①
select 2 * 5

-- 3-2-34 FROM を省略した例②
select current_date() as today

-- 3-2-5 フィールドの値同氏の演算結果を格納する
select order_id
, revenue
, quantity
, revenue / quantity
from sample.sales order by quantity desc

-- 3-2-6 新しいフィールドに別名を付ける
select order_id
, revenue
, quantity
, revenue / quantity as unit_price # unit_price という名称を設定する
from sample.sales order by quantity desc

-- 3-2-7 既存のフィールドに別名を付ける
select order_id, revenue as uriage  -- revenue を uriage という名称に変更
from sample.sales

-- 3-2-8 AS表記を省略した別名指定の書き方
select order_id, revenue uriage  -- revenue を uriage という名称に変更 (as を省略)
from sample.sales

-- 3-3-2 5つのレコードのみを取得する
select *
from sample.sales
limit 5  -- 読み込むレコードを5つに制限

-- 3-3-3 順序を指定して5つのレコードを取得
select order_id, date_time
from sample.sales
order by date_time desc  # limit で読み込むレコードを降順に取得
limit 5

-- 3-3-4 101~105番目のレコードを取得
select order_id, date_time
from sample.sales
order by date_time desc
limit 5 offset 100  -- 上位101~105番目のレコードを取得

-- 3-3-6 女性客の登録日が新しい順に5レコードを取得
select *
from sample.customers
where gender = 2   -- gender=2(女性客)を指定して抜き出し
order by register_date desc
limit 5

-- 3-3-9 AND の記述例
select * from sample.customers
where gender = 2 and birthday >= "1991-01-01"

-- 3-3-10 OR の記述例
select * from sample.sales
where quantity >= 4 or revenue >= 5000

-- 3-3-11 AND と OR を組み合わせた記述例①
select * from sample.customers
where (gender = 1 or prefecture = '東京')
and birthday >= "2000-01-01"

-- 3-3-12 AND と OR を組み合わせた記述例②
select * from sample.customers
where gender = 1 or (prefecture = '東京'
and birthday >= "2000-01-01")

-- 3-3-14 IN の記述例①
select * from sample.sales
where quantity in (2,4,6)  -- 2,4,6 のいずれの値に当てはまるレコードを取得

-- 3-3-15 IN の記述例②
select * from sample.customers
where prefecture in ("青森","岐阜","鹿児島")  -- いずれの値に当てはまるレコードを取得

-- 3-3-16 NOT IN の記述例
select * from sample.customers
where prefecture not in ("東京","大阪","愛知")  -- 指定以外を取得

-- 3-3-18 LIKE の記述例①
select * from sample.customers
where name like ("木%")   -- 「木～」のデータを取得する

/*
LIKE と組み合わせる記号の意味
% 任意の数の任意の文字
_ 1つの任意の文字
\ エスケープ処理をする
*/

-- 3-3-19 LIKE の記述例②
select * from sample.customers
where name like ("% __子")  # 「苗字 + 〇〇子(3文字)」のデータを取得する

-- 3-3-20 BETWEEN の記述例
select * from sample.customers
where birthday between "1999-01-01" and "1999-12-31"

-- 3-3-21 BETWEEN を使わない記述例
select * from sample.customers
where birthday >= "1999-01-01"
and birthday <= "1999-12-31"

-- 3-3-24 IS TRUE の記述例
select * from sample.sales
where is_proper is true

-- 3-3-25 IS NOT TRUE の記述例
select * from sample.sales
where is_proper is not true

-- 3-3-27 フィルターの例①
select * from sample.customers
where birthday >= "1999-01-01"

-- 3-3-28 フィルターの例②
select * from sample.customers
where birthday <= "1998-12-31"

-- 3-3-29 null のレコードを取得
select * from sample.customers
where birthday is null  -- 3-3-27 と 3-3-28 で取りこぼしている値を表示 (null値)

-- 3-3-30 null ではないレコードを取得
select * from sample.customers
where register_date is not null

-- 3-4-1 問題①
select * except (revenue)
, revenue*1.1 as revenue_with_tax
from sample.sales
order by 1
limit 3

-- 3-4-2 問題②
select order_id
, quantity
, quantity + 1 as new_quantity
, revenue
, (revenue / quantity) * (quantity + 1) as new_revenue
from sample.sales
order by 5 desc
limit 3

-- 3-4-3 問題③
select * from sample.customers
where birthday is not null and is_premium is true
order by birthday desc, register_date
limit 3

-- 3-4-4 問題④
select *
from sample.customers
where (is_premium is true or
birthday between "1970-01-01" and "1979-12-31")
and name like ("%美")
and gender = 2
order by birthday
limit 3

-- 4-1-9 グループ化して合計値を取得
select product_id, sum(quantity) as sum_qty
from sample.sales
group by product_id

-- 4-1-10 SELECT のフィールド名を省略して取得
select sum(quantity) as sum_qty
from sample.sales
group by product_id  -- 4-1-9 と異なり、product_id が表示されない

-- 4-2-3 グループ化してレコード数を取得
select user_id, count(*) as orders
from sample.sales
group by user_id

-- 4-2-4 グループ化して値の個数を取得
select user_id, count(product_id) as orders
from sample.sales
group by user_id

-- 4-2-5 グループ化して固有の値を取得
select user_id, count(distinct product_id) as orders  -- distinct = 固有の値のみ取得
from sample.sales
group by user_id

-- 4-2-6 合計値、平均値、最大値、最小値を取得
select user_id
, sum(quantity) as sum_qty
, avg(quantity) as avg_qty
, max(quantity) as max_qty
, min(quantity) as min_qty  -- いずれもnullは集計計算対象に入らないことに注意
from sample.sales
group by user_id

-- 4-2-7 グループ化せずに各種集計地を取得
select count(*) as count_row
, count(product_id) as count_product
, count(distinct product_id) as count_unique_product
, sum(quantity) as sum_qty
, avg(quantity) as avg_qty
, max(quantity) as max_qty
, min(quantity) as min_qty
from sample.sales

-- 4-2-8 最大値と最小値をすばやく取得する
select min(date_time), max(date_time)
from sample.web_log

-- 4-2-9 グループ化と集計関数を他の句と組み合わせる①
select prefecture, count(distinct user_id) as users
from sample.customers
where birthday <= "1999-12-31"
group by prefecture
order by 2 desc

-- 4-2-10 グループ化と集計関数を他の句と組み合わせる②
select user_id, product_id, avg(revenue) as avg_revenue
from sample.sales
where is_proper is true and product_id in (1,2)
group by user_id, product_id
order by avg_revenue desc
limit 5

-- 4-2-12 母集団から標準偏差を求める
select product_id
, stddev_pop(quantity) as stddev_qty
from `sample.sales`
where product_id in (1,2)
group by product_id

-- 4-3-1 グループ化して固有の値の個数を取得
select prefecture, count(distinct user_id) as users
from sample.customers
group by prefecture
order by 2 desc

-- 4-3-4 HAVING で集計結果を絞り込む
select prefecture, count(distinct user_id) as users
from sample.customers
group by prefecture
having users >= 20  -- グループ化したフィールドの絞り込みには Having を用いる
order by 2 desc

-- 4-3-5 WHERE と HAVING を併用
select prefecture, count(distinct user_id) as users
from sample.customers
where gender = 2 # WHERE と HAVING を併用
group by prefecture
having users >= 20  -- グループ化したフィールドの絞り込みには Having を用いる
order by 2 desc

-- 4-4-4 任意の2グループで集計する
select
if (birthday >= "1989-01-08"
, "平成以降生まれ","昭和以前生まれ") as era  -- if 真 偽 の順
, count(distinct user_id) as users
from sample.customers
group by era

-- 4-4-5 任意の2グループで集計 (OR を利用)
select
if (prefecture = "東京"
or prefecture = "神奈川"
or prefecture = "埼玉"
or prefecture = "千葉", "一都三県", "一都三県以外")
as pref_group
, count(distinct user_id) as users
from sample.customers
group by pref_group

-- 4-4-6 任意の2グループで集計する(IS NULL で判定)
select
if (birthday is null, "未登録", "登録済み")
as birthday_regist
, count(distinct user_id) as users
from sample.customers
group by birthday_regist

-- 4-4-9 都道府県を任意の3グループで集計①
select
case prefecture
when "東京" then "関東主要都県"
when "神奈川" then  "関東主要都県"
when "大阪" then  "関西主要都県"
when "京都" then  "関西主要都県"
when "兵庫" then  "関西主要都県"
else "その他"
end as prefecture_group
, count(distinct user_id) as users
from `sample.customers`
group by prefecture_group
order by 2 desc

-- 4-4-10 都道府県を任意の3グループで集計②
select
case
when "東京" then "関東主要都県"
when "神奈川" then  "関東主要都県"
when "大阪" then  "関西主要都県"
when "京都" then  "関西主要都県"
when prefecture = "兵庫" then  "関西主要都県"
else "その他"
end as prefecture_group
, count(distinct user_id) as users
from `sample.customers`
group by prefecture_group
order by 2 desc

-- 4-4-12 誕生日を任意の３グループで集計
select
case
when birthday >= "2000-01-01" then "2000年代生まれ"
when birthday >= "1990-01-01" then "1990年代生まれ"
when birthday >= "1980-01-01" then "1980年代生まれ"  -- 2000年代以降の記述の順序も大切なので留意
else "1970年代以前生まれ"
end as era_group
, count(distinct user_id) as users
from `sample.customers`
group by era_group
order by 2 desc

-- 5-2-4 INNER JOIN で結合（ON句を使用）
select hanbai.user_id,  -- user_id はどちらのテーブルにも含まれるため、どちらを主体とするか指定している
from sample.sales as hanbai  -- hanbai とテーブルを命名
inner join sample.customers as customers  -- customersとテーブルを命名
on hanbai.user_id = customers.user_id

-- 5-2-5 INNER JOIN で結合（USING句を使用）
select user_id
from sample.sales
inner join sample.customers
using (user_id)  -- 結合がシンプルなので、2つのテーブルで同一句で結合するときはおすすめ

-- 5-2-9 LEFT OUTER JOIN で結合
select user_id
from sample.sales
left outer join sample.customers
using (user_id)

-- 5-2-10 FULL OUTER JOIN で結合する
select * from sample.sales
full outer join sample.customers
using (user_id)

-- 5-3-2 単一の条件で結合する
select * from sample.sales as jisseki
join sample.customers as mokuhyo
on jisseki.user_id = mokuhyo.user_id

-- 5-3-3 複数の条件で結合する
select * from sample.sales as jisseki
join sample.customers as mokuhyo
on jisseki.user_id = mokuhyo.user_id and
jisseki.is_proper = mokuhyo.is_premium

-- 5-3-4 演算・並び替えと同時に複数の条件で結合する
select jisseki.user_id
, jisseki.product_id
, jisseki.revenue
, mokuhyo.prefecture
, jisseki.revenue / jisseki.quantity as achivement_rate
from sample.sales as jisseki
join sample.customers as mokuhyo
on jisseki.user_id = mokuhyo.user_id and
jisseki.is_proper = mokuhyo.is_premium

-- 5-3-8 3つのケーブルを結合する①（USING句を利用）
select *
from `sample.sales`
join sample.customers using (user_id)
join sample.sales using (product_id)
