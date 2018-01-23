class AddColumnResultStateToResult < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :state, :integer, default: 0
  end
end
