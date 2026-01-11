# README

## データベース設計

### usersテーブル
| Column               | Type       | Options                |
|----------------------|------------|-----------------------|
| id                   | bigint     | PK, auto_increment    |
| nickname             | string     | null: false           |
| email                | string     | null: false, unique   |
| encrypted_password   | string     | null: false           |
| created_at           | datetime   | null: false           |
| updated_at           | datetime   | null: false           |

### productsテーブル
| Column                  | Type       | Options                |
|-------------------------|------------|-----------------------|
| id                      | bigint     | PK, auto_increment    |
| user_id                 | bigint     | FK, null: false       |
| name                    | string     | null: false           |
| description             | text       | null: false           |
| category_id             | integer    | null: false           |
| condition_id            | integer    | null: false           |
| shipping_fee_status_id  | integer    | null: false           |
| prefecture_id           | integer    | null: false           |
| scheduled_delivery_id   | integer    | null: false           |
| price                   | integer    | null: false           |
| sold_out                | boolean    | default: false        |
| created_at              | datetime   | null: false           |
| updated_at              | datetime   | null: false           |

### purchasesテーブル
| Column         | Type       | Options                |
|----------------|------------|-----------------------|
| id             | bigint     | PK, auto_increment    |
| user_id        | bigint     | FK, null: false       |
| product_id     | bigint     | FK, null: false       |
| postal_code    | string     | null: false           |
| prefecture_id  | integer    | null: false           |
| city           | string     | null: false           |
| address        | string     | null: false           |
| building       | string     | optional              |
| phone_number   | string     | null: false           |
| created_at     | datetime   | null: false           |
| updated_at     | datetime   | null: false           |
