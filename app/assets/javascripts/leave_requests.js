function approvedLeaveRequest(employeeId,employeeRole,leaveRequestId){
	$.loader.open();
	data = {
		employee_id: employeeId,
		employee_role: employeeRole,
		leave_request_id: leaveRequestId,
		action: "approved"
	}
	$.ajax({
		url: "/leave_requests/update_status",
		type: "POST",
		data: {
			leave_request: data
		},
		dataType: "JSON",

		complete: function(){
			$.loader.close();
		},

		success: function(data){
			response = data
			if(response["status"] == 200){
				alert(response["message"])
				location.reload();
			}else{
				alert(response["error"])
			}
		},

		error: function(err_data){
			$.loader.close();
			alert(err_data)
		}
	})
}

function rejectedLeaveRequest(employeeId,employeeRole,leaveRequestId){
	$.loader.open();
	data = {
		employee_id: employeeId,
		employee_role: employeeRole,
		leave_request_id: leaveRequestId,
		action: "rejected"
	}
	$.ajax({
		url: "/leave_requests/update_status",
		type: "POST",
		data: {
			leave_request: data
		},
		dataType: "JSON",

		complete: function(){
			$.loader.close();
		},

		success: function(data){
			response = data
			if(response["status"] == 200){
				alert(response["message"])
				location.reload();
			}else{
				alert(response["error"])
			}
		},

		error: function(err_data){
			$.loader.close();
			alert(err_data)
		}
	})
}