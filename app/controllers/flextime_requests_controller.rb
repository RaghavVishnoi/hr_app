class FlextimeRequestsController < ApplicationController

	before_action :set_flextime_request, only: [:show]

	def index
		@flextime_requests = FlextimeRequest.all
	end

	def new
		@flextime_request = FlextimeRequest.new
	end

	def create
		flextime_request = FlextimeRequest.new(flextime_request_params.merge(employee_id: current_employee.id,status: 'New'))
		if flextime_request.save
			redirect_to flextime_requests_path,notice: 'Successfully created!'
		else
			render :new,notice: flextime_request.errors.full_messages
		end
	end

	def show
	end


	private
		def flextime_request_params
			params.require(:flextime_request).permit(:to,:from,:date,:beginning_date,:ending_date,:reason,:is_schedule_revoked,:day_schedule_revoked,:reason_schedule_revoked,:issues_resolved,:issue_resolve_date,:team_lead_id,:team_manager_id,:is_permission_issue,:is_employee_on_time,:is_flexible_schedule_revoked,:is_admin_issues_resolved,:is_hr_approval,:is_forward_person_approval,:terms_and_condition)
		end

		def set_flextime_request
			@flextime_request = FlextimeRequest.find(params[:id])
		end

end
