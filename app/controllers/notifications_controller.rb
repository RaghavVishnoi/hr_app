class NotificationsController < ApplicationController

	def index
		@notifications = Notification.where(employee_id: current_employee.id)
		@notifications.update(read: true)
	end

end
