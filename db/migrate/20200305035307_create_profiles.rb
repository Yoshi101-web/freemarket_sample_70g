class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.text :introduction
      t.string :user_image
      t.bigint :user_id, foreign_key:true
      t.timestamps
    end
  end
end
