function visitItem(item_id){
  location.assign("/item/"+item_id);
};

function initialize_datatables(){
	$('.datatable').DataTable({
		"aoColumnDefs" : [ { "bSortable": false, "aTargets" : [ "no-sort" ] } ]
	});
};