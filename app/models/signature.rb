class Signature < ApplicationRecord
  belongs_to :employee

  attr_accessor :content_type, :original_filename, :image_data, :sign_file_name

  has_attached_file :sign,
    :path => ":rails_root/public/signatures/#{}/:filename",
    :url  => "/signatures/:id/:filename"
  do_not_validate_attachment_file_type :sign
end
