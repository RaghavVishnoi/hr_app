class CreateReviewCatgQuests < ActiveRecord::Migration[5.0]
  def change
    create_table :review_catg_quests do |t|
      t.string :name
      t.integer :category_id

      t.timestamps
    end
    add_index :review_catg_quests, :category_id
  end
end
