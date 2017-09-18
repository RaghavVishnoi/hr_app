class AddAttachmentDocumentToDisclosures < ActiveRecord::Migration
  def self.up
    change_table :disclosures do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :disclosures, :document
  end
end
