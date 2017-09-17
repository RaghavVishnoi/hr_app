class AddTypeToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :document_type, :string
    add_column :documents, :template, :boolean
  end
end
