function changeStatus(new_status, request_id){
	$.ajax({
		url: '/change_status',
		data: {status: new_status, artist_request_id: request_id},
		type: 'post',
		success: function(){
			swal('Success', ['The request has been' , new_status].join(' '), 'success');
			$(['#artist_request_' , request_id].join('')).fadeOut();
		},
		fail: function(){
			swal('Error', 'Something went wrong', 'error');
			$(['#artist_request_' , request_id].join('')).fadeOut();
		}
	});
}