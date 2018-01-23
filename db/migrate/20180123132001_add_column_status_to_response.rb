class AddColumnStatusToResponse < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :status, :integer, default: 1
  end
end
