class DropTableModulePassword < ActiveRecord::Migration[5.0]
  def change
  	drop_table :module_passwords
  end
end
