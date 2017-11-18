function archiveEmployeeCall(id){
	$("#archiveEmployee").modal();
	$("#submitArchiveEmployee").click(function(){
		coverageId = $("#employee_coverage_id").val();
		terminationDate = $("#employeeTerminationDate").val();
		terminationComment = $("#employeeTerminationComment").val();
		terminateEmployee(id,coverageId,terminationDate,terminationComment)
	});
}

function generateExperienceReport(){
	$.loader.open();
	$.ajax({
		url: "/experience/report_all",
		type: "POST",
		data: {},
		dataType: "JSON",

		complete: function(){
			$.loader.close();
		},

		success: function(data){
			alert("Report successfully generated!")
		},

		error: function(err_data){
			$.loader.close();
			alert("Report successfully generated!")
		}
	})	
}

function experienceReportCall(id){
	$.loader.open();
	data = {
		employee_id: id,
	}
	$.ajax({
		url: "/experience/report",
		type: "POST",
		data: {
			experience: data
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

function terminateEmployee(employeeId,coverageId,terminationDate,terminationComment){
	$.loader.open();
	data = {
		employee_id: employeeId,
		coverage_id: coverageId,
		termination_date: terminationDate,
		termination_comment: terminationComment
	}
	$.ajax({
		url: "/employees/archive",
		type: "POST",
		data: {
			employee: data
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