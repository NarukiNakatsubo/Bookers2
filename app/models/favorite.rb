class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  # ユーザidとbookidのペアが一意である状態にする
  # 複数ある場合はいいねを複数行っている
  validates :user_id, uniqueness: {scope: :book_id}
end
