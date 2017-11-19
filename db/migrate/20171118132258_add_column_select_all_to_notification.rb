class AddColumnSelectAllToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :select_all, :boolean
  end
end
