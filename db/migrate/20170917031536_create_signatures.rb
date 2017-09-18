class CreateSignatures < ActiveRecord::Migration[5.0]
  def change
    create_table :signatures do |t|
      t.string :sign
      t.integer :employee_id

      t.timestamps
    end
    add_index :signatures, :employee_id
  end
end
