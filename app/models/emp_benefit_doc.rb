class EmpBenefitDoc < ApplicationRecord
  belongs_to :employee
  has_attached_file :document,
    :path => File.join(Rails.root, "/public/employee_benefits/:template_type/:employee_name/:filename")

  do_not_validate_attachment_file_type :document

  scope :templates, -> {where(template: 1)}

  Paperclip.interpolates :template_type do |attachment, style|
    attachment.instance.template_type
  end

  Paperclip.interpolates :employee_name do |attachment, style|
    attachment.instance.employee.name
  end

end
