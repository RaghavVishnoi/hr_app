function submitLeaveRequest(){
	coverId = $("#leave_request_cover_id").val();
    teamleadId = $("#leave_request_team_lead_id").val();
    datastring = $("#new_leave_request").serialize();
    if(coverId == 0 || teamleadId == 0){
      $("#escalationUser").modal('toggle');
      $("#submitEscalatedUser").click(function(){
      	escalationUserId = $("#leave_request_escalation_user_id").val();
      	if(escalationUserId != null && escalationUserId.length != 0 && escalationUserId != 0 && escalationUserId != "0"){
      		$.loader.open();
      		$.ajax({
	      	  	type: "POST",
	            url: "/leave_requests",
	            data: datastring,
	            dataType: "JSON",
	            complete: function(){
	            	$.loader.close();
	            },
	            success: function(data) {
	                if(data["status"] == 200){
	                	alert(data["message"])
	                	location.href = '/leave_requests'
	                }else{
	                	alert(data["message"])
	                	$("#escalationUser").modal('toggle');
	                	$("#leave_request_escalation_user_id").val("");
	                	return false;
	                }
	            },
	            error: function(error){
	            	console.log("error "+JSON.parse(error))
	            	alert(error)
	            }
	      	})
      	}else{
      		alert("Please select an escalation user!");
      		$("#leave_request_escalation_user_id").val("0");
      		return false;
      	}
      	  
      });
    }else{
    	$.loader.open();
    	$.ajax({
      	  	type: "POST",
            url: "/leave_requests",
            data: datastring,
            dataType: "JSON",
            complete: function(){
            	$.loader.close();
            },
            success: function(data) {
                if(data["status"] == 200){
                	alert(data["message"])
                	location.href = '/leave_requests'
                }else{
                	alert(data["message"])
                	return false;
                }
            },
            error: function(error){
            	console.log("error "+JSON.parse(error))
            	alert(error)
            }
      	})
    }
}

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