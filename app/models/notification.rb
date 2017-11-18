class Notification < ApplicationRecord

  before_create :set_users	

  belongs_to :employee, optional: true

  def self.add(title,description,redirect_uri,employee_id,notification_type)
  	Notification.create!(title: title,description: description,redirect_uri: redirect_uri,notification_type: notification_type,employee_id: employee_id)
  end

  def self.send_to_all(notification_params)
  	employee_ids = Employee.where(status: 'active').pluck(:id)
  	ids_to_send = employee_ids
  	employee_ids.each do |employee_id|
  		Notification.create(employee_id: employee_id,title: notification_params[:title],redirect_uri: "/notifications",notification_type: notification_params[:notification_type],description: notification_params[:description])
  		ids_to_send = ids_to_send - [employee_id]
  	end
  	if ids_to_send.present?
  		{result: false,ids: ids_to_send}
  	else
  		{result: true}
  	end
  end

  private
  	def set_users
  		if self.employee_id.nil? || self.employee_id.blank?
  			self.select_all ||= true
  		end
  	end

end
