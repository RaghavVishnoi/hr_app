class AddColumnEmployeeIdToFileUpload < ActiveRecord::Migration[5.0]
  def change
    add_reference :file_uploads, :employee, foreign_key: true
  end
end
