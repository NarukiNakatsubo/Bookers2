class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      
      # userモデルとの関連付け
      t.references :user, null: false, foreign_key: true

      t.timestamps
      t.string :title
      t.string :body
    end
  end
end
