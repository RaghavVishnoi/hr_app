class AddColumnStatusToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :status, :string,default: "active"
  end
end
