class NotificationsController < ApplicationController

	def index
		@notifications = Notification.where('employee_id = ? OR select_all = ?', current_employee.id,true)
		@notifications.update(read: true)
	end

	def new
		@notification = Notification.new
	end

	def create
		@notification = Notification.new(notification_params)
		if notification_params[:employee_id].present?
			if @notification.save
				redirect_to notifications_path,notice: "Successfully created!"
			else
				redirect_to "/notifications/new",notice: @notification.errors.full_messages
			end
		else
			result = Notification.send_to_all(notification_params)
			if result[:result]
				redirect_to notifications_path,notice: "Successfully created!"
			else
				redirect_to "/notifications/new",notice: "Employees with ids #{result[:ids]} didn't received the notification!"
			end
		end	
	end

	def show
		@notification = Notification.find(params[:id])
	end

	private
		def notification_params
			params.require(:notification).permit(:title,:description,:notification_type,:employee_id)
		end

end
