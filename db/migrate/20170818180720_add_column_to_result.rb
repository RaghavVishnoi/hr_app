class AddColumnToResult < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :status, :string, default: nil
  end
end
