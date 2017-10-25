module EmployeesHelper

	def self.termination_template(coverage,employee,termination_date,current_employee)
		'<div class="row clearfix">
		  <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		   	<div class="card" style="height: 500px;">
		   		<div class="custom-header" style="height: auto;border-bottom: 1px solid #000;padding-left:18%;">
		   			<h1>Employee Termination Report</h1>
		   		</div>
		   		<div style="color: #000;">
		   			<table class="table table-hover" style="font-size: 15px;width: 100%;">
			            <thead>
			              <tr>
			                <th style="width: 33%;text-align: left;">Date of archiving</th>
			                <th style="width: 33%;text-align: left;">Archived By</th>
			                <th style="width: 33%;text-align: left;">Termination Date</th>
			              </tr>
			            </thead>
			            <tbody>
			            	<tr>
			            		<td style="width: 33%;">'+String(Date.current)+'</td>
			            		<td style="width: 33%">'+String(current_employee.name)+'</td>
			            		<td style="width: 33%">'+String(termination_date)+'</td>
			            	</tr>
			            </tbody>
			        </table>
		   			<hr>
		   			<h4>Personal Detail:</h4>
		   			<table class="table table-hover" style="font-size: 15px;width: 100%;">
			            <thead>
			              <tr>
			                <th style="width: 33%;text-align: left;">First Name</th>
			                <th style="width: 33%;text-align: left;">Last Name</th>
			                <th style="width: 33%;text-align: left;">Address</th>
			              </tr>
			            </thead>
			            <tbody>
			            	<tr>
			            		<td style="width: 33%;">'+String(employee.first_name)+'</td>
			            		<td style="width: 33%">'+String(employee.last_name)+'</td>
			            		<td style="width: 33%">'+String(employee.address)+'</td>
			            	</tr>
			            </tbody>
			        </table>
			        <br>
			        <table class="table table-hover" style="font-size: 15px;width: 100%;">
			            <thead>
			              <tr>
			                <th style="width: 33%;text-align: left;">Personal Ph.</th>
			                <th style="width: 33%;text-align: left;">Email of coverage</th>
			                <th style="width: 33%;text-align: left;"></th>
			              </tr>
			            </thead>
			            <tbody>
			            	<tr>
			            		<td style="width: 33%;">'+String(employee.mobile)+'</td>
			            		<td style="width: 33%">'+String(coverage.email)+'</td>
			            		<td></td>
			            	</tr>
			            </tbody>
			        </table>'+performance_review(employee)+'
			        <br>
		   		</div>
		   	</div>
		  </div>
		</div>'
	end

	def self.performance_review(employee)
		review_html_head = '<hr>
		        <h4>Performance Review:</h4>
	   			<table class="table table-hover" style="font-size: 15px;width: 100%;">
		            <thead>
		              <tr>
		                <th style="width: 25%;text-align: left;">Date</th>
		                <th style="width: 25%;text-align: left;">Reviewed By</th>
		                <th style="width: 25%;text-align: left;">Review Rating</th>
		                <th style="width: 25%;text-align: left;">Comments</th>
		              </tr>
		            </thead>
		            <tbody>'
		review_html_body_data = ''   
		employee.perf_reviews.each do |review|
			review_html_body_data = review_html_body_data + '<tr>
			            		<td style="width: 25%;">'+String(review.created_at.strftime("%d %b,%Y"))+'</td>
			            		<td style="width: 25%">'+String(review.reviewer.try(:name))+'</td>
			            		<td style="width: 25%">'+String(review.avg)+'</td>
			            		<td style="width: 25%">'+String(review.catg_reviews)+'</td>
			            	</tr>'
		end 
		review_html_bottom = '</tbody>
		        </table>' 
		review_html_template = review_html_head+review_html_body_data+review_html_bottom               
		review_html_template
	end

	def self.leave_request
		leave_request_html_head = '<hr>
		        <h4>Leave Request:</h4>
	   			<table class="table table-hover" style="font-size: 15px;width: 100%;">
		            <thead>
		              <tr>
		                <th style="width: 25%;text-align: left;">From</th>
		                <th style="width: 25%;text-align: left;">To</th>
		                <th style="width: 25%;text-align: left;">Last Update Date</th>
		                <th style="width: 25%;text-align: left;">Status</th>
		              </tr>
		            </thead>
		            <tbody>'
		leave_request_html_body_data = ''   
		employee.leave_requests.each do |leave_request|
			leave_request_html_body_data = leave_request_html_body_data + '<tr>
			            		<td style="width: 25%;">'+String(leave_request.from.strftime("%d %b,%Y"))+'</td>
			            		<td style="width: 25%">'+String(leave_request.to.strftime("%d %b,%Y"))+'</td>
			            		<td style="width: 25%">'+String(leave_request.leave_response.last.try(response_date))+'</td>
			            		<td style="width: 25%">'+String(review.catg_reviews)+'</td>
			            	</tr>'
		end 
		leave_request_html_bottom = '</tbody>
		        </table>' 
		leave_request_html_template = review_html_head+review_html_body_data+review_html_bottom               
		leave_request_html_template
	end

end
