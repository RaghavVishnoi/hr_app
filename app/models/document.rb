class Document < ApplicationRecord
  belongs_to :employee
  has_attached_file :document,
    :path => ":rails_root/public/documents/:id/:filename",
    :url  => "/documents/:id/:filename"
  do_not_validate_attachment_file_type :document
end
