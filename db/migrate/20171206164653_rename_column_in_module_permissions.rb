class RenameColumnInModulePermissions < ActiveRecord::Migration[5.0]
  def change
  	remove_column :module_permissions,:module_name
  	add_column :module_permissions,:menu_id,:integer
  	add_foreign_key :module_permissions,:menus
  end
end
