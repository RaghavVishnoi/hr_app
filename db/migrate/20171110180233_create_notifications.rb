class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.string :redirect_uri
      t.string :type
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
