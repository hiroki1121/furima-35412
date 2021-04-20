## usersテーブル

|Column              |Type     |Options                    |
|--------------------|---------|---------------------------|
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| nickname           | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_ruby     | string  | null: false               |
| first_name_ruby    | string  | null: false               |
| birthday           | date    | null: false               |


### Association
- has_many :items
- has_many :orders

## itemsテーブル

|Column             |Type        |Options                         |
|-------------------|------------|--------------------------------|
| product_name      | string     | null: false                    |
| description       | text       | null: false                    |
| category_id       | integer    | null: false                    |
| product_status_id | integer    | null: false                    |
| shipping_id       | integer    | null: false                    |
| prefecture_id     | integer    | null: false                    |
| delivery_day_id   | integer    | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## ordersテーブル

|Column             |Type        |Options                         |
|-------------------|------------|--------------------------------|
| user              | references | null: false, foreign_key: true |
| item              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery

## deliverysテーブル

|Column             |Type        |Options                         |
|-------------------|------------|--------------------------------|
| post_code         | string     | null: false                    |
| prefecture_id     | integer    | null: false                    |
| municipality      | string     | null: false                    |
| address           | string     | null: false                    |
| building_name     | string     |                                |
| phone_num         | string     | null: false                    |
| order             | references | null: false, foreign_key: true |

### Association
- belongs_to :order