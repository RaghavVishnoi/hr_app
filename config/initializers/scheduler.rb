require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton


# scheduler.every '0 12 1 * *' do
#   EmployeeHour.all.each do |employee_hour|
#   	begin
#   		new_sick_hour = employee_hour.available_sick_hours + employee_hour.initial_sick_hours
#   		new_vocation_hour = employee_hour.available_vocation_hours + employee_hour.initial_vocation_hours
#   		employee_hour.update(available_sick_hours: new_sick_hour,available_vocation_hours: new_vocation_hour)
#   	rescue Exception => e
#   		puts e.backtrace
#   	end
#   end
# end

	scheduler.every '1h' do
	  PerfReviewRequest.notify_review_request
	end

