class FileUpload < ApplicationRecord

	mount_uploader :file, FileUploader

	belongs_to :employee

end
