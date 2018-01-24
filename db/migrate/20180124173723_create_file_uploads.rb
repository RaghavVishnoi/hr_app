class CreateFileUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :file_uploads do |t|
      t.string :title
      t.text :description
      t.string :file

      t.timestamps
    end
  end
end
