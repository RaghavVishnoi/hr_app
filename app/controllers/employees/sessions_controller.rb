class Employees::SessionsController < Devise::SessionsController
   before_action :configure_sign_in_params, only: [:create]
  @@employee=nil
  layout 'authentication'
  # GET /resource/sign_in
   def new
     super
   end

  # POST /resource/sign_in
   def create
     super  
     @@employee = Employee.find_by_email(sign_in_params[:email])

    if @@employee.employee_usage_logs.present? 
      if @@employee.employee_usage_logs.last.entry_type != "IN" 
       EmployeeUsageLog.create(employee_id: @@employee.id,entry_type: "IN" )
     else
       EmployeeUsageLog.create(employee_id: @@employee.id,entry_type: "IN" )
     end
   end
   end

  # DELETE /resource/sign_out
   def destroy
     super
     EmployeeUsageLog.create(employee_id: @@employee.id,entry_type: "OUT") if @@employee.present?
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
   end
end
