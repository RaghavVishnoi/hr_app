class AddColumnStatusToFlextimeRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :flextime_requests, :status, :string
  end
end
