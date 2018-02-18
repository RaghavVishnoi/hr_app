var updateStatus;

updateStatus = function(status, id) {
  params = {}
  params['status'] = status;
  $.ajax({
    url: '/reward_recommendation/'+id+'/update_status',
    type: 'POST',
    data: {
      reward_recommendation: params
    },
    dataType: 'json',
    complete: function() {},
    success: function(result) {
    	alert(result['message'])
    	location.href = '/reward_recommendations'
    },
    error: function(error) {}
  });
};