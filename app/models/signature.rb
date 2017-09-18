class Signature < ApplicationRecord
  belongs_to :employee

  has_attached_file :sign,
    :path => ":rails_root/public/signatures/:employee_id/:id/:filename"

  do_not_validate_attachment_file_type :sign

  Paperclip.interpolates :employee_id do |attachment, style|
    attachment.instance.employee_id
  end

  def sign_path
    "/signatures/#{employee_id}/#{id}/#{sign_file_name}"
  end

end
