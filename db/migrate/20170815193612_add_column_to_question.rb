class AddColumnToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :description, :string
  end
end
