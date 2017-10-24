function showCloseReason(employee_id,employee_role,id,action){
	$("#cancelReason").modal();
	$("#submitCancelComment").click(function(){
		comment = $("#cancelReasonComment").val();
		if(action == 'cancel'){
			cancelLeaveRequest(employee_id,employee_role,id,comment)
		}else if(action == 'reject'){
			rejectedLeaveRequest(employee_id,employee_role,id,comment)
		}
	});

	$('#cancelReason').on('hidden.bs.modal', function(e) {
		$("#cancelReasonComment").val("");
	});
}

function showForwardRequest(employee_id,employee_role,id){
	$("#forwardRequest").modal();
	$("#submitForwardRequest").click(function(){
		reporting_manager_id = $("#reporting_manager_id").val();
		console.log("dddddddd "+reporting_manager_id)
		forwardLeaveRequest(employee_id,employee_role,id,reporting_manager_id)
	});
}

function forwardLeaveRequest(employeeId,employeeRole,leaveRequestId,reporting_manager_id){
	$.loader.open();
	data = {
		employee_id: employeeId,
		employee_role: employeeRole,
		leave_request_id: leaveRequestId,
		reporting_manager_id: reporting_manager_id,
		action: "forward"
	}
	$.ajax({
		url: "/leave_requests/forward",
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

function rejectedLeaveRequest(employeeId,employeeRole,leaveRequestId,comment){
	$.loader.open();
	data = {
		employee_id: employeeId,
		employee_role: employeeRole,
		leave_request_id: leaveRequestId,
		comment: comment,
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

function cancelLeaveRequest(employeeId,employeeRole,leaveRequestId,comment){
	$.loader.open();
	data = {
		employee_id: employeeId,
		employee_role: employeeRole,
		leave_request_id: leaveRequestId,
		comment: comment,
		action: "cancel"
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