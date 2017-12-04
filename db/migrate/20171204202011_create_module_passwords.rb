class CreateModulePasswords < ActiveRecord::Migration[5.0]
  def change
    create_table :module_passwords do |t|
    	t.string :password
    	t.integer :employee_id
    	t.string :module
        t.timestamps
    end
    add_foreign_key :module_passwords,:employees
  end
end
