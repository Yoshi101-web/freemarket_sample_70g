class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.bigint     :user_id, foreign_key:true
      t.bigint     :item_id, foreign_key:true
      t.timestamps
    end
  end
end
