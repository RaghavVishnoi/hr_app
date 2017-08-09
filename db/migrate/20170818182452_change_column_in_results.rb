class ChangeColumnInResults < ActiveRecord::Migration[5.0]
  def change
    remove_column :results, :status
    add_column :results, :status, :boolean, default: nil
  end
end
