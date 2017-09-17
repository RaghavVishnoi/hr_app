class CreateSignatures < ActiveRecord::Migration[5.0]
  def change
    create_table :signatures do |t|
      t.string :sign
      t.integer :user_id

      t.timestamps
    end
    add_index :signatures, :user_id
  end
end
