require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton


	scheduler.every '5 0 * * *' do
	  EmployeeHour.all.each do |employee_hour|
	  	begin
	  		start_date = employee_hour.start_date
	  		if (start_date+1.month).to_date == Date.current
	  			employee_hour.available_sick_hours = employee_hour.available_sick_hours+employee_hour.sick_hours_multiplier if employee_hour.sick_hours_multiplier != nil 
	  		end
	  		if (start_date+1.year).to_date == Date.current
	  			employee_hour.available_vocation_hours = employee_hour.available_vocation_hours+employee_hour.vocation_hours_multiplier if employee_hour.sick_hours_multiplier != nil  
	  		end
	  		employee_hour.save
	  	rescue Exception => e
	  		puts e.backtrace
	  	end
	  end
	end

	scheduler.every '1h' do
	  PerfReviewRequest.notify_review_request
	end

