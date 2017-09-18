class CreateEmpBenefitDocs < ActiveRecord::Migration[5.0]
  def change
    create_table :emp_benefit_docs do |t|
      t.integer :employee_id
      t.boolean :template
      t.string :template_type

      t.timestamps
    end
    add_index :emp_benefit_docs, :employee_id
  end
end
