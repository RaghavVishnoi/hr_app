class AddColumnToLeaves < ActiveRecord::Migration[5.0]
  def change
    add_column :leaves, :status, :string
    add_column :leaves, :applicable_id, :integer
    add_column :leaves, :applicable, :string
  end
end
