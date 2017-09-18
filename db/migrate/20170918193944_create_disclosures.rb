class CreateDisclosures < ActiveRecord::Migration[5.0]
  def change
    create_table :disclosures do |t|
      t.integer :employee_id
      t.boolean :template

      t.timestamps
    end
  end
end
