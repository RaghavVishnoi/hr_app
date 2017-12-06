class CreateDefaultModules < ActiveRecord::Migration[5.0]
  def change
    create_table :default_modules do |t|
       t.integer :menu_id
       t.integer :role_id
       t.timestamps
    end
    add_foreign_key :default_modules,:menus
    add_foreign_key :default_modules,:roles
  end
end
