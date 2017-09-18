class AddAttachmentSignToSignatures < ActiveRecord::Migration
  def self.up
    change_table :signatures do |t|
      t.attachment :sign
    end
  end

  def self.down
    remove_attachment :signatures, :sign
  end
end
