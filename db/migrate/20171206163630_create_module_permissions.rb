class CreateModulePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :module_permissions do |t|
    	t.string :module_name
    	t.integer :employee_id
        t.timestamps
    end
    add_foreign_key :module_permissions,:employees
  end
end
