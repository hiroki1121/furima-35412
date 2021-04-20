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

|Column          |Type        |Options                         |
|----------------|------------|--------------------------------|
| product_name   | string     | null: false                    |
| description    | text       | null: false                    |
| category       | integer    | null: false                    |
| product_status | integer    | null: false                    |
| shipping       | integer    | null: false                    |
| delivery_area  | integer    | null: false                    |
| delivery_day   | integer    | null: false                    |
| price          | integer    | null: false                    |
| order          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## ordersテーブル

|Column             |Type        |Options                         |
|-------------------|------------|--------------------------------|
| credit_num        | integer    | null: false                    |
| credit_expiration | integer    | null: false                    |
| security_code     | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |
| item              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery

## deliverysテーブル

|Column             |Type        |Options                         |
|-------------------|------------|--------------------------------|
| post_code         | integer    | null: false                    |
| prefecture        | string     | null: false                    |
| municipality      | string     | null: false                    |
| address           | string     | null: false                    |
| building_name     | string     | null: true                     |
| phone_num         | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association
- belongs_to :order