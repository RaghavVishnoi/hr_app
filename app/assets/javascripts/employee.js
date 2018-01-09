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

function secureReviewPassword(){
	$("#review_password").val("");
	$("#securePassword").modal('toggle');
}

function submitSecurePassword(module_type){
	password = $("#review_password").val();
	if(password != null && password.length != 0){
		data_module = module_type
		$.loader.open();
		$.ajax({
			url: "/perf_review/password",
			type: "POST",
			data: {
				review_password: password,
				data_module: module_type
			},
			dataType: "json",
			complete: function(){
				$.loader.close();
			},
			success: function(response){
				console.log(response)
				if(response['status'] == 200){
					$("#secure-reviews").attr("style","display: block");
					$("#securePassword").modal('hide');
				}else if(response['status'] == 422){
					alert("Sorry! wrong password");
					$("#secure-reviews").attr("style","display: none");
					$("#securePassword").modal('hide');
				}else{
					alert("Sorry! you don't have permission");
					$("#secure-reviews").attr("style","display: none");	
					$("#securePassword").modal('hide');
				}
			},
			error: function(){

			}
		})
	}else{
		alert("Please enter password!")
	}
}

function claculateAverage(){
	$("#avgCalculator").modal('toggle');
	$(".calculator-values p").not(':first').remove();
	$("#avgCalculator input").val("");
	$("#recordCount").val("");
	$(".avgTotal").text("");
}

function addNewCalField(){
	oldFieldsCount = $(".calculator-values p").length
	fieldHtml = '<p><input type="text" id="cal-'+(oldFieldsCount+1)+'" class="avg-field-value"></p>'
	$(".calculator-values").append(fieldHtml);
}

function removeNewCalField(){
	if($(".calculator-values p").length > 1){
		$(".calculator-values").children().last().remove()
	}
}

function calculateFinalAvg(){
	var totalValues = 0;
	$(".avg-field-value").each(function(){
		console.log("number "+$(this).val())
		totalValues += Number($(this).val());
	})
	console.log("total val "+totalValues)
	totalRecords = parseInt($("#recordCount").val());
	totalAverage = (totalValues/totalRecords);
	$(".avgTotal").text(totalAverage.toFixed(3));
}

function editPerfReviewPage(){
	
}

