class AddAttachmentDocumentToEmpBenefitDocs < ActiveRecord::Migration
  def self.up
    change_table :emp_benefit_docs do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :emp_benefit_docs, :document
  end
end
