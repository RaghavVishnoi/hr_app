class AddColumnNoteToExperience < ActiveRecord::Migration[5.0]
  def change
    add_column :experiences, :note, :string
  end
end
