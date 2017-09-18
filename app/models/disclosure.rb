class Disclosure < ApplicationRecord
  belongs_to :employee
  has_attached_file :document,
    :path => ":rails_root/public/disclosures/:employee_id/:id/:filename",
    :url  => "/documents/:id/:filename"
  do_not_validate_attachment_file_type :document

  scope :templates, -> {where(template: 1)}

  Paperclip.interpolates :employee_id do |attachment, style|
    attachment.instance.employee_id
  end

end
