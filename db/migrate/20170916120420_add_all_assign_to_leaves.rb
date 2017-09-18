class AddAllAssignToLeaves < ActiveRecord::Migration[5.0]
  def change
    add_column :leaves, :all_assign, :integer
  end
end
