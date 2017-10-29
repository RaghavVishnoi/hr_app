module EmployeesHelper

	def self.termination_template(employee,coverage,termination_date,current_employee)
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
		   			<h4>Personal Details:</h4>
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
			        </table>'+personal_document(employee)+employee_disclosure(employee)+performance_review(employee)+leave_request(employee)+issue(employee)+exam(employee)+'
			        <br>
		   		</div>
		   	</div>
		  </div>
		</div>'
	end

	def self.personal_document(employee)
		personal_document_html_head = '<hr>
		        <h4>Personal Documents:</h4>
	   			<table class="table table-hover" style="font-size: 15px;width: 100%;">
		            <thead>
		              <tr>
		                <th style="width: 25%;text-align: left;">Document Name</th>
		                <th style="width: 25%;text-align: left;">Is Template</th>
		                <th style="width: 25%;text-align: left;">Uploaded By</th>
		              </tr>
		            </thead>
		            <tbody>'
		personal_document_html_body_data = ''   
		employee.emp_benefit_docs.each do |document|
			personal_document_html_body_data = personal_document_html_body_data + '<tr>
			            		<td style="width: 25%;">'+String(document.document_file_name)+'</td>
			            		<td style="width: 25%">'+String(document.template ? 'Yes' : 'No')+'</td>
			            		<td style="width: 25%">'+String(document.employee.name)+'</td>
                      			</td>
			            	</tr>'
		end 
		personal_document_html_bottom = '</tbody>
		        </table>' 
		personal_document_html_template = personal_document_html_head+personal_document_html_body_data+personal_document_html_bottom               
		personal_document_html_template
	end

	def self.employee_disclosure(employee)
		disclosure_html_head = '<hr>
		        <h3>Disclosures:</h3>
	   			<table class="table table-hover" style="font-size: 15px;width: 100%;">
		            <thead>
		              <tr>
		                <th style="width: 25%;text-align: left;">Document Name</th>
		                <th style="width: 25%;text-align: left;">Type</th>
		                <th style="width: 25%;text-align: left;">Uploaded By</th>
		              </tr>
		            </thead>
		            <tbody>'
		disclosure_html_body_data = ''   
		employee.disclosures.each do |disclosure|
			disclosure_html_body_data = disclosure_html_body_data + '<tr>
			            		<td style="width: 25%;">'+String(disclosure.document_file_name)+'</td>
			            		<td style="width: 25%">'+String(disclosure.template ? 'Unsigned' : 'Signed')+'</td>
			            		<td style="width: 25%">'+String(disclosure.employee.name)+'</td>
			            	</tr>'
		end 
		disclosure_html_bottom = '</tbody>
		        </table>' 
		disclosure_html_template = disclosure_html_head+disclosure_html_body_data+disclosure_html_bottom               
		disclosure_html_template
	end

	def self.performance_review(employee)
		review_html_head = '<hr>
		        <h3>Performance Reviews:</h3>
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

	def self.leave_request(employee)
		leave_request_html_head = '<hr>
		        <h3>Leave Requests:</h3>
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
			            		<td style="width: 25%">'+String(leave_request.leave_responses.last.try(:response_date))+'</td>
			            		<td style="width: 25%">'+String(leave_request.status)+'</td>
			            	</tr>'
		end 
		leave_request_html_bottom = '</tbody>
		        </table><br>' 
		leave_request_html_template = leave_request_html_head+leave_request_html_body_data+leave_request_html_bottom               
		leave_request_html_template
	end

	def self.issue(employee)
		issue_html_head = '<hr><br><br>
		        <h3>Issues:</h3>
	   			<table class="table table-hover" style="font-size: 15px;width: 100%;">
		            <thead>
		              <tr>
		                <th style="width: 25%;text-align: left;">Title</th>
		                <th style="width: 25%;text-align: left;">Description</th>
		                <th style="width: 25%;text-align: left;">Date</th>
		                <th style="width: 25%;text-align: left;">Solved By</th>
		              </tr>
		            </thead>
		            <tbody>'
		issue_html_body_data = ''   
		employee.issues.each do |issue|
			issue_html_body_data = issue_html_body_data + '<tr>
			            		<td style="width: 25%;">'+String(issue.title)+'</td>
			            		<td style="width: 25%">'+String(issue.description)+'</td>
			            		<td style="width: 25%">'+String(issue.created_at.strftime("%d %b,%Y"))+'</td>
			            		<td style="width: 25%">'+String(issue.solver.name)+'</td>
			            	</tr>'
		end 
		issue_html_bottom = '</tbody>
		        </table>' 
		issue_html_template = issue_html_head+issue_html_body_data+issue_html_bottom               
		issue_html_template
	end

	def self.exam(employee)
		exams_html_head = '<hr>
		        <h3>Exams:</h3>
	   			<table class="table table-hover" style="font-size: 15px;width: 100%;">
		            <thead>
		              <tr>
		                <th style="width: 15%;text-align: left;">Exam Date</th>
		                <th style="width: 15%;text-align: left;">Exam Team</th>
		                <th style="width: 20%;text-align: left;">Subject</th>
		                <th style="width: 25%;text-align: left;">Passed?</th>
		                <th style="width: 25%;text-align: left;">Marks Obtained</th>
		              </tr>
		            </thead>
		            <tbody>'
		exams_html_body_data = ''   
		employee.exams.each do |exam|
			exams_html_body_data = exams_html_body_data + '<tr>
			            		<td style="width: 15%;">'+String(exam.created_at.strftime("%d %b,%Y"))+'</td>
			            		<td style="width: 15%">'+String(exam.team.name)+'</td>
			            		<td style="width: 20%">'+String(exam.subject.title)+'</td>
			            		<td style="width: 25%">'+String(exam.is_passed?)+'</td>
			            		<td style="width: 25%">'+String(exam.marks)+'</td>
			            	</tr>'
		end 
		exams_html_bottom = '</tbody>
		        </table>' 
		exams_html_template = exams_html_head+exams_html_body_data+exams_html_bottom               
		exams_html_template
	end

	# -------------------------------------------- Experience Template ------------------------------------------ #

	def self.experience_template(employee,experience)
		'<div class="row clearfix">
		  <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		   	<div class="card" style="height: 500px;">
		   		<div class="custom-header" style="height: auto;border-bottom: 1px solid #000;padding-left:18%;">
		   			<h1>Employee Experience Report</h1>
		   		</div>
		   		<div style="color: #000;">
		   			<table class="table table-hover" style="font-size: 15px;width: 100%;">
			            <thead>
			              <tr>
			                <th style="width: 33%;text-align: left;">Date of Joining</th>
			                <th style="width: 33%;text-align: left;">First Name</th>
			                <th style="width: 33%;text-align: left;">Last Name</th>
			              </tr>
			            </thead>
			            <tbody>
			            	<tr>
			            		<td style="width: 33%;">'+String(employee.created_at.strftime("%d %b,%Y"))+'</td>
			            		<td style="width: 33%">'+String(employee.first_name)+'</td>
			            		<td style="width: 33%">'+String(employee.last_name)+'</td>
			            	</tr>
			            </tbody>
			        </table>'+employee_experience(experience)+'
		   		</div>
		   	</div>
		  </div>
		</div>'
	end

	def self.employee_experience(experience)
		experience_html_head = '<hr>
        <h3>Experience:</h3>'
        
		experience_html_body_data = ''   
		experience.each do |exp|
			experience_html_body_data = experience_html_body_data + '<table class="table table-hover" style="font-size: 15px;width: 100%;">
            			<thead></thead><tbody>
            				<tr>
			            		<td style="width: 15%;"><b>Title: </b></td>
			            		<td>'+String(exp.title)+'</td>
			            	</tr>
			            	<tr>
			            		<td style="width: 15%;"><b>From: </b></td>
			            		<td>'+String(exp.from_date.strftime("%d %b,%Y"))+'</td>
			            	</tr>
			            	<tr>
			            		<td style="width: 15%;"><b>To: </b></td>
			            		<td>'+String(exp.to_date.strftime("%d %b,%Y"))+'</td>
			            	</tr>
			            	<tr>
			            		<td style="width: 15%;"><b>Description: </b></td>
			            		<td>'+String(exp.description)+'</td>
			            	</tr>
			            </tbody></table><br><br><hr>'
		end 
		experience_html_bottom = '' 
		experience_html_template = experience_html_head+experience_html_body_data+experience_html_bottom               
		experience_html_template
	end


	# ------------------------------------------------------------------------------------------------------------#

end
