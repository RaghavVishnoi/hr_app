class Notification < ApplicationRecord
  belongs_to :employee

  def self.add(title,description,redirect_uri,employee_id,notification_type)
  	Notification.create!(title: title,description: description,redirect_uri: redirect_uri,notification_type: notification_type,employee_id: employee_id)
  end

end
