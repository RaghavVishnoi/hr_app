class FlextimeRequestsController < ApplicationController


	def new
		@flextime_request = FlextimeRequest.new
	end

end
