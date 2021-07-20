# README
# テーブル設計

## users テーブル
| Column             | Type    | Options                       |
| ------------------ | ------- | ----------------------------- |
| nickname           | string  | null: false                   |
| email              | string  | null: false, unique: true     |
| encrypted_password | string  | null: false                   |
| character          | string  | null: false                   |
| character_name     | string  | null: false, default: "たまご" |
| level              | integer | null: false, default: "1"     |
| experience_point   | integer | null: false, default: "0"     |

### Association

- has_many :questions
- has_many :answers
- has_many :scores


## questions テーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| genre_id           | integer    | null: false                    |
| question_name      | string     | null: false                    |
| question_content   | string     | null: false                    |
| tip                | string     |                                |
| model_answer       | string     | null: false                    |
| point              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many   :answers


## answers テーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| question           | references | null: false, foreign_key: true |
| answer_content     | string     | null: false                    |

### Association
- belongs_to :user
- belongs_to :question
- has_one    :score


## scores テーブル
| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| answer   | references | null: false, foreign_key: true |
| score    | integer    | null: false                    |

### Association
- belongs_to :user
- belongs_to :answer


## level_setting テーブル
| Column             | Type    | Options      |
| ------------------ | ------- | ------------ |
| level              | integer | null: false  |
| thresold           | integer | null: false  |

### Association


## beetle_evolution テーブル
| Column             | Type    | Options      |
| ------------------ | ------- | ------------ |
| level              | integer | null: false  |
| character_name     | string  | null: false  |

### Association

## stag_beetle_evolution テーブル
| Column             | Type    | Options      |
| ------------------ | ------- | ------------ |
| level              | integer | null: false  |
| character_name     | string  | null: false  |

### Association