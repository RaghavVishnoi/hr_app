class CreateDataPasswords < ActiveRecord::Migration[5.0]
  def change
    create_table :data_passwords do |t|
    	t.string :data_type
    	t.integer :employee_id
    	t.datetime :expiry_date
    	t.string :password_digest
        t.timestamps
    end
    add_foreign_key :data_passwords,:employees
  end
end
