$(function(){
	$('#check_out').click(function(){
		swal({
			title: "Are you sure?",
			text: "You want to proceed to the check out",
			type: "warning",
			showCancelButton: true,
			confirmButtonText: "Proceed",
			cancelButtonText: "Cancel",
			closeOnConfirm: false,
			closeOnCancel: false },
			function(isConfirm){
				if (isConfirm) {
					window.location.assign("/checkout")
				} else {
					swal("Cancelled", "You can edit your cart", "error");
				} 
			}
		);
	});
});