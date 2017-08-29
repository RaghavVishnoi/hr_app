class CreateSwitchDays < ActiveRecord::Migration[5.0]
  def change
    create_table :switch_days do |t|
      t.references :employee, foreign_key: true
      t.date :real_date
      t.date :replace_date

      t.timestamps
    end
  end
end
