function archiveEmployeeCall(id){
	$("#archiveEmployee").modal();
	$("#submitArchiveEmployee").click(function(){
		coverageId = $("#employee_coverage_id").val();
		terminationDate = $("#employeeTerminationDate").val();
		terminateEmployee(id,coverageId,terminationDate)
	});
}

function terminateEmployee(employeeId,coverageId,terminationDate){
	$.loader.open();
	data = {
		employee_id: employeeId,
		coverage_id: coverageId,
		termination_date: terminationDate
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