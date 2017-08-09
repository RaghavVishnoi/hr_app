class AddRoleToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_reference :employees, :role, foreign_key: true
  end
end
